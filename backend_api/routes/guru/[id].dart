import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import '../../lib/database.dart';
import '../../lib/models/guru.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final connection = await createConnection();
  final guruId = int.tryParse(id);
  if (guruId == null) {
    return Response.json(statusCode: 400, body: {'error': 'Invalid ID'});
  }

  try {
    switch (context.request.method) {
      case HttpMethod.get:
        final results = await connection.query(
          '''
          SELECT id_guru, id_users, nip, nama_guru, jenis_kelamin, no_hp
          FROM guru
          WHERE id_guru = @id_guru;
          ''',
          substitutionValues: {'id': guruId},
        );
        if (results.isEmpty) return Response(statusCode: 404);
        return Response.json(body: Guru.fromRow(results.first).toJson());

      case HttpMethod.put:
        final body = await context.request.body();
        final jsonMap = json.decode(body) as Map<String, dynamic>;

        await connection.query(
          '''
            UPDATE guru
          SET id_users = @id_users,
              nip = @nip,
              nama_guru = @nama_guru,
              jenis_kelamin = @jenis_kelamin,
              no_hp = @no_hp
          WHERE id_guru = @id_guru;
          ''',
          substitutionValues: {
            'id_guru': guruId,
            'id_users': jsonMap['id_users'],
            'nip': jsonMap['nip'],
            'nama_guru': jsonMap['nama_guru'],
            'jenis_kelamin': jsonMap['jenis_kelamin'],
            'no_hp': jsonMap['no_hp'],
          },
        );

        return Response.json(body: {'message': 'Guru updated'});

      case HttpMethod.delete:
        await connection.query(
          'DELETE FROM guru WHERE id_guru = @id;',
          substitutionValues: {'id': guruId},
        );

        return Response.json(body: {'message': 'Guru deleted'});

      default:
        return Response(statusCode: 405);
    }
  } catch (e) {
    return Response.json(statusCode: 500, body: {'error': e.toString()});
  } finally {
    await connection.close();
  }
}
