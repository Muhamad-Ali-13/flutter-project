import 'package:postgres/postgres.dart';

Future<PostgreSQLConnection> createConnection() async {
  final connection = PostgreSQLConnection(
    'localhost',  // Host
    5433,  // Port PostgreSQL
    'absensi',  // db_strongnet
    username: 'postgres',  // Username DB
    password: '130405',  // Password DB
    
  );
  await connection.open();  // Membuka koneksi ke database
  return connection;
}
