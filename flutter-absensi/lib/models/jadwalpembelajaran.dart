class JadwalPembelajaran {
  final int idJadwal;
  final String namaMatapelajaran;
  final int idGuru;

  JadwalPembelajaran({
    required this.idJadwal,
    required this.namaMatapelajaran,
    required this.idGuru,
  });

  // Convert from JSON to JadwalPembelajaran object
  factory JadwalPembelajaran.fromJson(Map<String, dynamic> json) {
    return JadwalPembelajaran(
      idJadwal: json['id_jadwal'],
      namaMatapelajaran: json['nama_matapelajaran'],
      idGuru: json['id_guru'],
    );
  }

  // Convert from JadwalPembelajaran object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_jadwal': idJadwal,
      'nama_matapelajaran': namaMatapelajaran,
      'id_guru': idGuru,
    };
  }
}
