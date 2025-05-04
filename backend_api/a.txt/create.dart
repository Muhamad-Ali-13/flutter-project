// import 'dart:convert';
// import 'package:dart_frog/dart_frog.dart';
// import '../lib/database.dart';

// Future<Response> onRequest(RequestContext context) async {
//   // Cek method request
//   if (context.request.method != HttpMethod.post) {
//     return Response(statusCode: 405, body: 'Method Not Allowed');
//   }

//   try {
//     await connectDB(); // Pastikan koneksi database berhasil
//   } catch (e) {
//     return Response(statusCode: 500, body: 'Database connection error: $e');
//   }

//   try {
//     final body = await context.request.body();
//     final data = jsonDecode(body);
//     final id_siswa = data['id_siswa']?.toString();
//     final id_users = data['id_users']?.toString();
//     final nama_lengkap = data['nama_lengkap']?.toString();
//     final tanggal_lahir = data['tanggal_lahir']?.toString();
//     final alamat = data['alamat']?.toString();
//     final no_hp = data['no_hp']?.toString();
//     final kelas = data['kelas']?.toString();
//     final id_guru = data['id_guru']?.toString();
//     final jenis_kelamin = data['jenis_kelamin']?.toString();

  

//     // Validasi input
//     if ([id_siswa,id_users,nama_lengkap,tanggal_lahir,alamat,no_hp,kelas,id_guru,kelas,jenis_kelamin].contains(null)) {
//       return Response(
//         statusCode: 400,
//         body: 'Missing one or more required fields.',
//       );
//     }

//     // Insert ke database
//     await db.query(
//       '''
//       INSERT INTO siswa (id_siswa,id_users,nama_lengkap,tanggal_lahir,alamat,no_hp,kelas,id_guru,kelas,jenis_kelamin)
//       VALUES (@id_siswa,@id_users,@nama_lengkap,@tanggal_lahir,@alamat,@no_hp,@kelas,@id_guru,@kelas,@jenis_kelamin)
//       ''',
//       substitutionValues: {
//         'id_siswa': id_siswa,
//         'id_users': id_users,
//         'nama_lengkap': nama_lengkap,
//         'tanggal_lahir': tanggal_lahir,
//         'alamat': alamat,
//         'no_hp': no_hp,
//         'kelas': kelas,
//         'id_guru': id_guru,
//         // ignore: equal_keys_in_map
//         'kelas': kelas,
//         'jenis_kelamin': jenis_kelamin,

//       },
//     );

//     return Response.json(
//       statusCode: 201,
//       body: {'message': 'Siswa created successfully'},
//     );
//   } catch (e) {
//     return Response(
//       statusCode: 500,
//       body: 'Error processing request: $e',
//     );
//   }
// }
