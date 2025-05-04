// import 'dart:convert';
// import 'package:dart_frog/dart_frog.dart';
// import '../lib/database.dart';

// Future<Response> onRequest(RequestContext context) async {
//   if (context.request.method != HttpMethod.put) {
//     return Response(statusCode: 405, body: 'Method Not Allowed');
//   }

//   await connectDB();

//   final body = await context.request.body();
//   final data = jsonDecode(body);

//   // ignore: avoid_dynamic_calls
//   final id_siswa = data['id_siswa'];
//   // ignore: avoid_dynamic_calls
//   final id_users = data['id_users'];
//   // ignore: avoid_dynamic_calls
//   final nama_lengkap = data['nama_lengkap'];
//   // ignore: avoid_dynamic_calls
//   final tanggal_lahir = data['tanggal_lahir'];
//   // ignore: avoid_dynamic_calls
//   final alamat = data['alamat'];
//   // ignore: avoid_dynamic_calls
//   final no_hp = data['no_hp'];
//   // ignore: avoid_dynamic_calls
//   final kelas = data['kelas'];
//   // ignore: avoid_dynamic_calls
//   final id_guru = data['id_guru'];
//   // ignore: avoid_dynamic_calls
//   final jenis_kelamin = data['jenis_kelamin'];

//   if (id_siswa == null) {
//     return Response(
//       statusCode: 400,
//       body: 'Missing id_siswa',
//     );
//   }

//   try {
//     await db.query(
//       '''
//       UPDATE siswa
//       SET 
//         id_siswa = COALESCE(@id_siswa, id_siswa),
//         id_users = COALESCE(@id_users, id_users),
//         nama_lengkap = COALESCE(@nama_lengkap, nama_lengkap),
//         tanggal_lahir = COALESCE(@tanggal_lahir, tanggal_lahir),
//         alamat = COALESCE(@alamat, alamat),
//         no_hp = COALESCE(@no_hp, no_hp),
//         kelas = COALESCE(@kelas, kelas),
//         id_guru = COALESCE(@id_guru, id_guru),
//         jenis_kelamin = COALESCE(@jenis_kelamin, jenis_kelamin)
//       WHERE id_siswa = @id_siswa
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
//         'jenis_kelamin': jenis_kelamin,
//       },
//     );

//     return Response.json(
//       body: {'message': 'siswa updated successfully'},
//     );
//   } catch (e) {
//     return Response(
//       statusCode: 500,
//       body: 'Error updating user: $e',
//     );
//   }
// }
