import 'package:dio/dio.dart';
import '../api/api_client.dart';
import '../models/user.dart';
import '../services/storage_service.dart';

class AuthApi {
  static Future<User> login(String email, String password) async {
    final response = await ApiClient.instance.post('/login', data: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = response.data;
      final token = data['token'];

      // Simpan token ke SharedPreferences
      await StorageService.saveToken(token);

      return User.fromJson(data['user']);
    } else {
      throw Exception('Gagal login');
    }
  }
}
