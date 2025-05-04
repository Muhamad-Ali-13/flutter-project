import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import '../../lib/database.dart';
import '../../lib/models/user.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final connection = await createConnection();
  final userId = int.tryParse(id);
  if (userId == null) {
    return Response.json(statusCode: 400, body: {'error': 'Invalid ID'});
  }

  try {
    switch (context.request.method) {
      case HttpMethod.get:
        final results = await connection.query(
          '''
            SELECT id_users, username, email, password, role
            FROM users
            WHERE id_users = @id_users;
            ''',
          substitutionValues: {'id_users': userId},
        );
        if (results.isEmpty) return Response(statusCode: 404);
        return Response.json(body: User.fromRow(results.first).toJson());

      case HttpMethod.put:
        final body = await context.request.body();
        final jsonMap = json.decode(body) as Map<String, dynamic>;

        // Update name, email, role
        await connection.query(
          '''
          UPDATE users
          SET username = @username,
              email = @email,
              password = crypt(@password, gen_salt('bf')),
              role = @role
          WHERE id_users = @id_users;
          ''',
          substitutionValues: {
            'id_users': userId,
            'username': jsonMap['username'],
            'email': jsonMap['email'],
            'password': jsonMap['password'],
            'role': jsonMap['role'],
          },
        );

        // Only update password if provided and non-empty
        final newPassword = jsonMap['password'] as String?;
        if (newPassword != null && newPassword.isNotEmpty) {
          await connection.query(
            '''
            UPDATE users
            SET password = crypt(@password, gen_salt('bf'))
            WHERE id_users = @id_users;
            ''',
            substitutionValues: {
              'id_users': userId,
              'password': newPassword,
            },
          );
        }

        return Response.json(body: {'message': 'User updated'});

      case HttpMethod.delete:
        await connection.query(
          'DELETE FROM users WHERE id_users = @id_users;',
          substitutionValues: {'id_users': userId},
        );
        return Response.json(body: {'message': 'User deleted'});

      default:
        return Response(statusCode: 405);
    }
  } catch (e) {
    return Response.json(statusCode: 500, body: {'error': e.toString()});
  } finally {
    await connection.close();
  }
}
