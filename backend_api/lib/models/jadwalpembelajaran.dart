class JadwalPembelajaran {
  final int idJadwal;
  final int idGuru;
  final String kelas;
  final String mapel;
  final String hari;
  final String jamMulai;  // Gunakan String untuk waktu
  final String jamSelesai; // Gunakan String untuk waktu

  JadwalPembelajaran({
    required this.idJadwal,
    required this.idGuru,
    required this.kelas,
    required this.mapel,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
  });

  factory JadwalPembelajaran.fromRow(List<dynamic> row) {
    // Periksa apakah nilai jam_mulai dan jam_selesai adalah DateTime
    String jamMulai = row[5] is DateTime ? (row[5] as DateTime).toIso8601String().substring(11, 19) : row[5].toString();
    String jamSelesai = row[6] is DateTime ? (row[6] as DateTime).toIso8601String().substring(11, 19) : row[6].toString();

    return JadwalPembelajaran(
      idJadwal: row[0] as int,
      idGuru: row[1] as int,
      kelas: row[2] as String,
      mapel: row[3] as String,
      hari: row[4] as String,
      jamMulai: jamMulai,
      jamSelesai: jamSelesai,
    );
  }

  factory JadwalPembelajaran.fromJson(Map<String, dynamic> json) {
    return JadwalPembelajaran(
      idJadwal: json['id_jadwal'] as int,
      idGuru: json['id_guru'] as int,
      kelas: json['kelas'] as String,
      mapel: json['mapel'] as String,
      hari: json['hari'] as String,
      jamMulai: json['jam_mulai'] as String,
      jamSelesai: json['jam_selesai'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_jadwal': idJadwal,
      'id_guru': idGuru,
      'kelas': kelas,
      'mapel': mapel,
      'hari': hari,
      'jam_mulai': jamMulai,
      'jam_selesai': jamSelesai,
    };
  }
}
