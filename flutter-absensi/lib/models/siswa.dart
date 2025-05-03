class Siswa {
  final int idSiswa;
  final int idUser;
  final String namaLengkap;
  final String tanggalLahir;
  final String alamat;
  final String noHp;
  final String kelas;
  final int idGuru;
  final String jenisKelamin;

  Siswa({
    required this.idSiswa,
    required this.idUser,
    required this.namaLengkap,
    required this.tanggalLahir,
    required this.alamat,
    required this.noHp,
    required this.kelas,
    required this.idGuru,
    required this.jenisKelamin,
  });

  // Convert from JSON to Siswa object
  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      idSiswa: json['id_siswa'],
      idUser: json['id_users'],
      namaLengkap: json['nama_lengkap'],
      tanggalLahir: json['tanggal_lahir'],
      alamat: json['alamat'],
      noHp: json['no_hp'],
      kelas: json['kelas'],
      idGuru: json['id_guru'],
      jenisKelamin: json['jenis_kelamin'],
    );
  }

  // Convert from Siswa object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_siswa': idSiswa,
      'id_users': idUser,
      'nama_lengkap': namaLengkap,
      'tanggal_lahir': tanggalLahir,
      'alamat': alamat,
      'no_hp': noHp,
      'kelas': kelas,
      'id_guru': idGuru,
      'jenis_kelamin': jenisKelamin,
    };
  }
}
