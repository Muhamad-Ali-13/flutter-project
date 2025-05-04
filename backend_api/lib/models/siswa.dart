class Siswa {
  final int idSiswa;
  final int idUsers;
  final String namaLengkap;
  final String nis;
  final DateTime tanggalLahir;
  final String alamat;
  final String noHp;
  final String kelas;
  final int idGuru;
  final String jenisKelamin;

  Siswa({
    required this.idSiswa,
    required this.idUsers,
    required this.namaLengkap,
    required this.nis,
    required this.tanggalLahir,
    required this.alamat,
    required this.noHp,
    required this.kelas,
    required this.idGuru,
    required this.jenisKelamin,
  });

  factory Siswa.fromRow(List<dynamic> row) => Siswa(
        idSiswa: row[0] as int,
        idUsers: row[1] as int,
        namaLengkap: row[2] as String,
        nis: row[3] as String,
        tanggalLahir: row[4] as DateTime,
        alamat: row[5] as String,
        noHp: row[6] as String,
        kelas: row[7] as String,
        idGuru: row[8] as int,
        jenisKelamin: row[9] as String,
      );

  factory Siswa.fromJson(Map<String, dynamic> json) => Siswa(
        idSiswa: json['id_siswa'] as int,
        idUsers: json['id_users'] as int,
        namaLengkap: json['nama_lengkap'] as String,
        nis: json['nis'] as String,
        tanggalLahir: json['tanggal_lahir'] as DateTime,
        alamat: json['alamat'] as String,
        noHp: json['no_hp'] as String,
        kelas: json['kelas'] as String,
        idGuru: json['id_guru'] as int,
        jenisKelamin: json['jenis_kelamin'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id_siswa': idSiswa,
        'id_users': idUsers,
        'nama_lengkap': namaLengkap,
        'nis': nis,
        'tanggal_lahir': tanggalLahir.toIso8601String(), // <- diubah
        'alamat': alamat,
        'no_hp': noHp,
        'kelas': kelas,
        'id_guru': idGuru,
        'jenis_kelamin': jenisKelamin,
      };
}
