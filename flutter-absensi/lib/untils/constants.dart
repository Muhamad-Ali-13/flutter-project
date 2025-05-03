import 'package:flutter/material.dart';

class Constants {
  // Warna yang digunakan dalam aplikasi
  static const Color primaryColor = Color(0xFF6200EE); // Warna utama
  static const Color secondaryColor = Color(0xFF03DAC5); // Warna sekunder
  static const Color backgroundColor = Color(0xFFF5F5F5); // Background
  static const Color textColor = Color(0xFF212121); // Warna teks utama

  // Ukuran font
  static const double titleFontSize = 24.0;
  static const double subtitleFontSize = 18.0;
  static const double bodyFontSize = 14.0;
  static const double buttonFontSize = 16.0;

  // URL API (contoh)
  static const String apiUrl = 'https://api.example.com/';
  static const String loginUrl = '${apiUrl}auth/login';
  static const String registerUrl = '${apiUrl}auth/register';
  static const String getSiswaUrl = '${apiUrl}siswa';
  static const String getGuruUrl = '${apiUrl}guru';

  // Konstanta lainnya
  static const String appName = 'Absensi App';
}
