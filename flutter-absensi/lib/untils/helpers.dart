import 'package:intl/intl.dart';

class Helpers {
  // Fungsi untuk format tanggal
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date); // Format YYYY-MM-DD
  }

  // Fungsi untuk format waktu (jam:menit)
  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time); // Format HH:MM
  }

  // Fungsi untuk menampilkan tanggal dalam format panjang
  static String formatLongDate(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy').format(date); // Format: Senin, 1 Januari 2025
  }

  // Fungsi untuk menampilkan mata uang
  static String formatCurrency(double amount) {
    final format = NumberFormat.simpleCurrency(locale: 'id_ID');
    return format.format(amount);
  }
}
