import 'dart:io';
import 'dart:typed_data';
import 'package:dart_frog/dart_frog.dart';
import '../../lib/database.dart';
import '../../lib/models/absensi.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final absensiId = int.tryParse(id);
  if (absensiId == null) return Response.json(statusCode: 400, body: {'error': 'Invalid ID'});

  final conn = await createConnection();
  try {
    // Handle GET request: Get absensi by ID
    if (context.request.method == HttpMethod.get) {
      final rows = await conn.query('''
        SELECT
          a.id,
          a.id_siswa,
          a.id_jadwal,
          a.tanggal,
          a.jam_masuk,
          a.jam_keluar,
          a.status,
          a.foto_absensi,
          a.keterangan,
          s.nama_siswa,
          j.nama_jadwal
        FROM absensi a
        JOIN siswa s ON a.id_siswa = s.id
        JOIN jadwal j ON a.id_jadwal = j.id
        WHERE a.id = @id;
      ''', substitutionValues: {'id': absensiId});

      if (rows.isEmpty) return Response.json(statusCode: 404, body: {'error': 'Not found'});

      final absensiData = rows.first;

      // Jika foto_absensi berupa Uint8List, kita perlu mengubahnya menjadi URL string (jika disimpan sebagai file)
      String? fotoAbsensi;
      if (absensiData[7] is Uint8List) {
        fotoAbsensi = '/uploads/${absensiData[7]}'; // path atau URL gambar
      } else {
        fotoAbsensi = absensiData[7] as String?; // Jika foto_absensi sudah berupa string
      }

      final absensi = Absensi(
        id: absensiData[0] as int,
        idSiswa: absensiData[1] as int,
        idJadwal: absensiData[2] as int,
        tanggal: absensiData[3] as String,
        jamMasuk: absensiData[4] as String,
        jamKeluar: absensiData[5] as String,
        status: absensiData[6] as String,
        fotoAbsensi: fotoAbsensi,
        keterangan: absensiData[8] as String,
      );

      return Response.json(body: absensi.toJson());
    }

    // Handle PUT request: Update absensi by ID
    if (context.request.method == HttpMethod.put) {
      // Ambil data lama
      final rec = await conn.query(
        'SELECT foto_absensi FROM absensi WHERE id = @id',
        substitutionValues: {'id': absensiId},
      );
      if (rec.isEmpty) return Response.json(statusCode: 404, body: {'error': 'Not found'});
      final oldImage = rec.first[0] as String?;

      // Parse multipart form-data
      final formData = await context.request.formData();
      final status = formData.fields['status'];
      final keterangan = formData.fields['keterangan'];

      if (status == null) return Response.json(statusCode: 400, body: {'error': 'Missing status field'});

      // Handle optional file upload
      String? imageName;
      final filePart = formData.files['foto_absensi'];
      if (filePart != null) {
        // Delete old image if exists
        if (oldImage != null) {
          final f = File('.$oldImage');
          if (await f.exists()) await f.delete();
        }

        // Read file and save to 'uploads' folder
        final bytes = Uint8List.fromList(await filePart.readAsBytes());
        final ext = filePart.name.split('.').last;
        imageName = 'absensi_${DateTime.now().millisecondsSinceEpoch}.$ext';
        await Directory('uploads').create(recursive: true);
        await File('uploads/$imageName').writeAsBytes(bytes);
      }

      // Update absensi in database
      await conn.query('''
        UPDATE absensi
        SET status = @status,
            keterangan = @keterangan
            ${imageName != null ? ', foto_absensi = @foto' : ''}
        WHERE id = @id;
      ''', substitutionValues: {
        'status': status,
        'keterangan': keterangan,
        if (imageName != null) 'foto': '/uploads/$imageName',
        'id': absensiId,
      });

      return Response.json(body: {'message': 'Absensi updated'});
    }

    // Handle DELETE request: Delete absensi by ID
    if (context.request.method == HttpMethod.delete) {
      final rec2 = await conn.query(
        'SELECT foto_absensi FROM absensi WHERE id = @id',
        substitutionValues: {'id': absensiId},
      );
      if (rec2.isEmpty) return Response.json(statusCode: 404, body: {'error': 'Not found'});
      final oldImage2 = rec2.first[0] as String?;

      // Delete absensi and old image if exists
      await conn.transaction((ctx) async {
        await ctx.query('DELETE FROM absensi WHERE id = @id', substitutionValues: {'id': absensiId});
        if (oldImage2 != null) {
          final f2 = File('.$oldImage2');
          if (await f2.exists()) await f2.delete();
        }
      });

      return Response.json(body: {'message': 'Absensi deleted'});
    }

    return Response(statusCode: 405); // Method Not Allowed
  } catch (e) {
    return Response.json(statusCode: 500, body: {'error': e.toString()});
  } finally {
    await conn.close();
  }
}
