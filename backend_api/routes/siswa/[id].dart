import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import '../../lib/database.dart';
import '../../lib/models/siswa.dart'; // pastikan ada model siswa.dart

Future<Response> onRequest(RequestContext context, String id) async {
  final connection = await createConnection();
  final siswaId = int.tryParse(id);
  if (siswaId == null) {
    return Response.json(statusCode: 400, body: {'error': 'Invalid ID'});
  }

  try {
    switch (context.request.method) {
      case HttpMethod.get:
        final results = await connection.query(
          '''
          SELECT id_siswa, id_users, nama_lengkap, nis, tanggal_lahir, 
                 alamat, no_hp, kelas, id_guru, jenis_kelamin
          FROM siswa
          WHERE id_siswa = @id;
          ''',
          substitutionValues: {'id': siswaId},
        );
        if (results.isEmpty) return Response(statusCode: 404);
        return Response.json(body: Siswa.fromRow(results.first).toJson());

      case HttpMethod.put:
        final body = await context.request.body();
        final jsonMap = json.decode(body) as Map<String, dynamic>;

        await connection.query(
          '''
          UPDATE siswa
          SET nama_lengkap  = @namaLengkap,
              nis           = @nis,
              tanggal_lahir = @tanggalLahir,
              alamat        = @alamat,
              no_hp         = @noHp,
              kelas         = @kelas,
              id_guru       = @idGuru,
              jenis_kelamin = @jenisKelamin
          WHERE id_siswa = @id;
          ''',
          substitutionValues: {
            'id': siswaId,
            'namaLengkap': jsonMap['nama_lengkap'],
            'nis': jsonMap['nis'],
            'tanggalLahir': jsonMap['tanggal_lahir'],
            'alamat': jsonMap['alamat'],
            'noHp': jsonMap['no_hp'],
            'kelas': jsonMap['kelas'],
            'idGuru': jsonMap['id_guru'],
            'jenisKelamin': jsonMap['jenis_kelamin'],
          },
        );

        return Response.json(body: {'message': 'Siswa updated'});

      case HttpMethod.delete:
        await connection.query(
          'DELETE FROM siswa WHERE id_siswa = @id;',
          substitutionValues: {'id': siswaId},
        );

        return Response.json(body: {'message': 'Siswa deleted'});

      default:
        return Response(statusCode: 405);
    }
  } catch (e) {
    return Response.json(statusCode: 500, body: {'error': e.toString()});
  } finally {
    await connection.close();
  }
}
