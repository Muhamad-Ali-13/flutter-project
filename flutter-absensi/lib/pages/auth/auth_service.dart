
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../pages/auth/login_page.dart'; // Pastikan import LoginPage sesuai dengan lokasi file

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('jwt_token');
  await prefs.remove('role');

  // Arahkan ke halaman login setelah logout
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
}
