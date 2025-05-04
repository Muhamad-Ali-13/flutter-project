import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import '../../lib/database.dart';
import '../../lib/models/jadwalpembelajaran.dart';

Future<Response> onRequest(RequestContext context) async {
  final connection = await createConnection();
  try {
    switch (context.request.method) {
      case HttpMethod.get:
        final results = await connection.query(
          '''
          SELECT id_jadwal, id_guru, kelas, mapel, hari, jam_mulai, jam_selesai
          FROM jadwal_pembelajaran
          ORDER BY id_jadwal;
          ''',
        );
        final list = results.map((row) => JadwalPembelajaran.fromRow(row).toJson()).toList();
        return Response.json(body: list);

      case HttpMethod.post:
        final body = await context.request.body();
        final jsonMap = json.decode(body) as Map<String, dynamic>;

        final result = await connection.query(
          '''
          INSERT INTO jadwal_pembelajaran (id_guru, kelas, mapel, hari, jam_mulai, jam_selesai)
          VALUES (@id_guru, @kelas, @mapel, @hari, @jam_mulai, @jam_selesai)
          RETURNING id_jadwal;
          ''',
          substitutionValues: {
            'id_guru': jsonMap['id_guru'],
            'kelas': jsonMap['kelas'],
            'mapel': jsonMap['mapel'],
            'hari': jsonMap['hari'],
            'jam_mulai': jsonMap['jam_mulai'],
            'jam_selesai': jsonMap['jam_selesai'],
          },
        );
        final newJadwalId = result.first[0] as int;

        return Response.json(
          statusCode: 201,
          body: {'message': 'Jadwal created', 'id_jadwal': newJadwalId},
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
