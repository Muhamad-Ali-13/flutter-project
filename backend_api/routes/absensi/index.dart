import 'dart:io';
import 'dart:typed_data';
import 'package:dart_frog/dart_frog.dart';
import '../../lib/database.dart';
import '../../lib/models/absensi.dart';

Future<Response> onRequest(RequestContext context) async {
  final conn = await createConnection();

  try {
    if (context.request.method == HttpMethod.get) {
      // GET semua absensi
      final results = await conn.query('''
        SELECT id, id_siswa, id_jadwal, tanggal, jam_masuk, jam_keluar, status, foto_absensi, keterangan
        FROM absensi
        ORDER BY id DESC;
      ''');

      final list = results.map((row) => Absensi.fromRow(row).toJson()).toList();
      return Response.json(body: list);
    }

    if (context.request.method == HttpMethod.post) {
      // POST buat absensi baru
      final formData = await context.request.formData();

      final idSiswa = int.tryParse(formData.fields['id_siswa'] ?? '');
      final idJadwal = int.tryParse(formData.fields['id_jadwal'] ?? '');
      final tanggal = formData.fields['tanggal'];
      final jamMasuk = formData.fields['jam_masuk'];
      final jamKeluar = formData.fields['jam_keluar'];
      final status = formData.fields['status'];
      final keterangan = formData.fields['keterangan'];

      if (idSiswa == null || idJadwal == null || tanggal == null || jamMasuk == null || status == null) {
        return Response.json(statusCode: 400, body: {'error': 'Missing required fields'});
      }

      // handle foto upload
      String? fotoPath;
      final filePart = formData.files['foto_absensi'];
      if (filePart != null) {
        final bytes = Uint8List.fromList(await filePart.readAsBytes());
        final ext = filePart.name.split('.').last;
        final fileName = 'absensi_${DateTime.now().millisecondsSinceEpoch}.$ext';
        final uploadDir = Directory('uploads/absensi');
        await uploadDir.create(recursive: true);
        final file = File('${uploadDir.path}/$fileName');
        await file.writeAsBytes(bytes);
        fotoPath = '/uploads/absensi/$fileName';
      }

      final result = await conn.query('''
        INSERT INTO absensi (id_siswa, id_jadwal, tanggal, jam_masuk, jam_keluar, status, foto_absensi, keterangan)
        VALUES (@idSiswa, @idJadwal, @tanggal, @jamMasuk, @jamKeluar, @status, @fotoAbsensi, @keterangan)
        RETURNING id;
      ''', substitutionValues: {
        'idSiswa': idSiswa,
        'idJadwal': idJadwal,
        'tanggal': tanggal,
        'jamMasuk': jamMasuk,
        'jamKeluar': jamKeluar,
        'status': status,
        'fotoAbsensi': fotoPath,
        'keterangan': keterangan,
      });

      final newId = result.first[0] as int;
      return Response.json(statusCode: 201, body: {'message': 'Absensi created', 'id': newId});
    }

    return Response(statusCode: 405);
  } catch (e) {
    return Response.json(statusCode: 500, body: {'error': e.toString()});
  } finally {
    await conn.close();
  }
}
