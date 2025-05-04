import 'dart:convert';
import 'package:dart_frog/dart_frog.dart';
import '../../lib/database.dart';
import '../../lib/models/siswa.dart'; // pastikan ada model siswa.dart

Future<Response> onRequest(RequestContext context) async {
  final connection = await createConnection();
  try {
    switch (context.request.method) {
      // GET all siswa
      case HttpMethod.get:
        final results = await connection.query(
          '''
          SELECT id_siswa, id_users, nama_lengkap, nis, tanggal_lahir,
                 alamat, no_hp, kelas, id_guru, jenis_kelamin
          FROM siswa
          ORDER BY id_siswa;
          ''',
        );
        final list = results.map((row) => Siswa.fromRow(row).toJson()).toList();
        return Response.json(body: list);

      // POST create new siswa
      case HttpMethod.post:
        final body = await context.request.body();
        final jsonMap = json.decode(body) as Map<String, dynamic>;

        await connection.query(
          '''
          INSERT INTO siswa
            (id_users, nama_lengkap, nis, tanggal_lahir, alamat, no_hp, kelas, id_guru, jenis_kelamin)
          VALUES
            (@idUsers, @namaLengkap, @nis, @tanggalLahir, @alamat, @noHp, @kelas, @idGuru, @jenisKelamin);
          ''',
          substitutionValues: {
            'idUsers': jsonMap['id_users'],
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

        return Response.json(
          statusCode: 201,
          body: {'message': 'Siswa created'},
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
