import 'package:dio/dio.dart';
import 'api_client.dart';

class AuthApi {
  static final _apiClient = ApiClient();

  // Login API
  static Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await _apiClient.post('/auth/login', {
        'email': email,
        'password': password,
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Logout API
  static Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout', {});
    } catch (e) {
      rethrow;
    }
  }

  // Register API (jika perlu)
  static Future<Map<String, dynamic>?> register(String name, String email, String password) async {
    try {
      final response = await _apiClient.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
