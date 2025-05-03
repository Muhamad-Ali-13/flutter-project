class Guru {
  final int idGuru;
  final int idUser;
  final String namaLengkap;
  final String noHp;
  final String jenisKelamin;

  Guru({
    required this.idGuru,
    required this.idUser,
    required this.namaLengkap,
    required this.noHp,
    required this.jenisKelamin,
  });

  // Convert from JSON to Guru object
  factory Guru.fromJson(Map<String, dynamic> json) {
    return Guru(
      idGuru: json['id_guru'],
      idUser: json['id_user'],
      namaLengkap: json['nama_lengkap'],
      noHp: json['no_hp'],
      jenisKelamin: json['jenis_kelamin'],
    );
  }

  // Convert from Guru object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_guru': idGuru,
      'id_user': idUser,
      'nama_lengkap': namaLengkap,
      'no_hp': noHp,
      'jenis_kelamin': jenisKelamin,
    };
  }
}
