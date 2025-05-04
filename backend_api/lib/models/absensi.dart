// lib/models/absensi.dart
class Absensi {
  final int id;
  final int idSiswa;
  final int idJadwal;
  final String tanggal;
  final String jamMasuk;
  final String jamKeluar;
  final String status;
  final String? fotoAbsensi;
  final String keterangan;

  Absensi({
    required this.id,
    required this.idSiswa,
    required this.idJadwal,
    required this.tanggal,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.status,
    this.fotoAbsensi,
    required this.keterangan,
  });

  /// Membuat instance dari satu baris hasil query
  factory Absensi.fromRow(List row) {
    // Menggunakan operator `as` dengan pengecekan tipe data
    DateTime? parseDateTime(dynamic value) {
      if (value is DateTime) {
        return value;
      }
      if (value is String) {
        try {
          return DateTime.parse(value);
        } catch (e) {
          // Jika gagal parse, kembalikan null
          return null;
        }
      }
      return null; // Jika bukan DateTime atau String, kembalikan null
    }

    return Absensi(
      id: row[0] as int,
      idSiswa: row[1] as int,
      idJadwal: row[2] as int,
      tanggal: parseDateTime(row[3])?.toIso8601String() ?? '', // Cek dan konversi jika valid
      jamMasuk: parseDateTime(row[4])?.toIso8601String() ?? '', // Cek dan konversi jika valid
      jamKeluar: parseDateTime(row[5])?.toIso8601String() ?? '', // Cek dan konversi jika valid
      status: row[6] as String,
      fotoAbsensi: row[7] as String?, // Foto bisa null
      keterangan: row[8] as String,
    );
  }

  /// Konversi ke format JSON
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
      'keterangan': keterangan,
    };
  }
}
