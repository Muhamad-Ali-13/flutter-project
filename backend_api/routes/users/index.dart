import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import '../../lib/database.dart';
import '../../lib/models/user.dart';

Future<Response> onRequest(RequestContext context) async {
  final connection = await createConnection();
  try {
    switch (context.request.method) {
      // GET all users
      case HttpMethod.get:
        final results = await connection.query(
          '''
          SELECT id_users, username, email, password, role
          FROM users
          ORDER BY id_users;
          ''',
        );
        final list = results.map((row) => User.fromRow(row).toJson()).toList();
        return Response.json(body: list);

      // POST create new user
      case HttpMethod.post:
        final body = await context.request.body();
        final jsonMap = json.decode(body) as Map<String, dynamic>;

        final userResult = await connection.query(
          '''
          INSERT INTO users (id_users, username, email, password, role)
          VALUES (@id_users, @username, @email, crypt(@password, gen_salt('bf')), @role)
          RETURNING id_users;
          ''',
          substitutionValues: {
            'id_users': jsonMap['id_users'],
            'username': jsonMap['username'],
            'email': jsonMap['email'],
            'password': jsonMap['password'],
            'role': jsonMap['role'],
          },
        );
        final newUserId = userResult.first[0] as int;

        return Response.json(
          statusCode: 201,
          body: {'message': 'User created', 'id_user': newUserId},
        );

      default:
        return Response(statusCode: 405);
    }
  } catch (e) {
    return Response.json(statusCode: 500, body: {'error': e.toString()});
  } finally {
    await connection.close();
  }
}
