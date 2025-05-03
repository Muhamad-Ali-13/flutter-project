class Absensi {
  final int id;
  final int idSiswa;
  final int idJadwal;
  final String tanggal;
  final String jamMasuk;
  final String jamKeluar;
  final String status;
  final String fotoAbsensi;

  Absensi({
    required this.id,
    required this.idSiswa,
    required this.idJadwal,
    required this.tanggal,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.status,
    required this.fotoAbsensi,
  });

  // Convert from JSON to Absensi object
  factory Absensi.fromJson(Map<String, dynamic> json) {
    return Absensi(
      id: json['id'],
      idSiswa: json['id_siswa'],
      idJadwal: json['id_jadwal'],
      tanggal: json['tanggal'],
      jamMasuk: json['jam_masuk'],
      jamKeluar: json['jam_keluar'],
      status: json['status'],
      fotoAbsensi: json['foto_absensi'],
    );
  }

  // Convert from Absensi object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_siswa': idSiswa,
      'id_jadwal': idJadwal,
      'tanggal': tanggal,
      'jam_masuk': jamMasuk,
      'jam_keluar': jamKeluar,
      'status': status,
      'foto_absensi': fotoAbsensi,
    };
  }
}
