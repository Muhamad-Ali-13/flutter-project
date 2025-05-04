// import 'dart:convert';
// import 'package:dart_frog/dart_frog.dart';
// import '../lib/database.dart';

// Future<Response> onRequest(RequestContext context) async {
//   if (context.request.method != HttpMethod.delete) {
//     return Response(statusCode: 405, body: 'Method Not Allowed');
//   }

//   await connectDB();

//   final body = await context.request.body();
//   final data = jsonDecode(body);
//   final idUsers = data['id_users'];

//   if (idUsers == null) {
//     return Response(
//       statusCode: 400,
//       body: 'Missing id_users',
//     );
//   }

//   try {
//     await db.query(
//       'DELETE FROM users WHERE id_user = @id_user',
//       substitutionValues: {'id_users': idUsers},
//     );

//     return Response.json(
//       body: {'message': 'Siswa deleted successfully'},
//     );
//   } catch (e) {
//     return Response(
//       statusCode: 500,
//       body: 'Error deleting siswa: $e',
//     );
//   }
// }
