import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import '../../lib/database.dart';
import '../../lib/models/jadwalpembelajaran.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final connection = await createConnection();
  final jadwalId = int.tryParse(id);
  if (jadwalId == null) {
    return Response.json(statusCode: 400, body: {'error': 'Invalid ID'});
  }

  try {
    switch (context.request.method) {
      case HttpMethod.get:
        final results = await connection.query(
          '''
          SELECT id_jadwal, id_guru, kelas, mapel, hari, jam_mulai, jam_selesai
          FROM jadwal_pembelajaran
          WHERE id_jadwal = @id_jadwal;
          ''',
          substitutionValues: {'id_jadwal': jadwalId},
        );
        if (results.isEmpty) return Response(statusCode: 404);
        return Response.json(body: JadwalPembelajaran.fromRow(results.first).toJson());

      case HttpMethod.put:
        final body = await context.request.body();
        final jsonMap = json.decode(body) as Map<String, dynamic>;

        await connection.query(
          '''
          UPDATE jadwal_pembelajaran
          SET id_guru = @id_guru,
              kelas = @kelas,
              mapel = @mapel,
              hari = @hari,
              jam_mulai = @jam_mulai,
              jam_selesai = @jam_selesai
          WHERE id_jadwal = @id_jadwal;
          ''',
          substitutionValues: {
            'id_jadwal': jadwalId,
            'id_guru': jsonMap['id_guru'],
            'kelas': jsonMap['kelas'],
            'mapel': jsonMap['mapel'],
            'hari': jsonMap['hari'],
            'jam_mulai': jsonMap['jam_mulai'],
            'jam_selesai': jsonMap['jam_selesai'],
          },
        );

        return Response.json(body: {'message': 'Jadwal updated'});

      case HttpMethod.delete:
        await connection.query(
          'DELETE FROM jadwal_pembelajaran WHERE id_jadwal = @id_jadwal;',
          substitutionValues: {'id_jadwal': jadwalId},
        );
        return Response.json(body: {'message': 'Jadwal deleted'});

      default:
        return Response(statusCode: 405);
    }
  } catch (e) {
    return Response.json(statusCode: 500, body: {'error': e.toString()});
  } finally {
    await connection.close();
  }
}
