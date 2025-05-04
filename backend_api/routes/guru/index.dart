import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import '../../lib/database.dart';
import '../../lib/models/guru.dart';

Future<Response> onRequest(RequestContext context) async {
  final connection = await createConnection();
  try {
    switch (context.request.method) {
      // GET all guru
      case HttpMethod.get:
        final results = await connection.query(
          '''
          SELECT id_guru, id_users, nip, nama_guru, jenis_kelamin, no_hp
          FROM guru
          ORDER BY id_guru;
          ''',
        );
        final list = results.map((row) => Guru.fromRow(row).toJson()).toList();
        return Response.json(body: list);

      // POST create new guru
      case HttpMethod.post:
        final body = await context.request.body();
        final jsonMap = json.decode(body) as Map<String, dynamic>;

        await connection.query(
          '''
          INSERT INTO guru (id_users, nip, nama_guru, jenis_kelamin, no_hp)
          VALUES (@id_users, @nip, @nama_guru, @jenis_kelamin, @no_hp)
          RETURNING id_guru;
          ''',
          substitutionValues: {
            'id_users': jsonMap['id_users'],
            'nip': jsonMap['nip'],
            'nama_guru': jsonMap['nama_guru'],
            'jenis_kelamin': jsonMap['jenis_kelamin'],
            'no_hp': jsonMap['no_hp'],
          },
        );

        return Response.json(
          statusCode: 201,
          body: {'message': 'Guru created'},
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
