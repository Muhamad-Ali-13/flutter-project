import 'package:dio/dio.dart';
import 'api_client.dart';

class GuruApi {
  static final _apiClient = ApiClient();

  // Ambil daftar guru
  static Future<List<dynamic>> getAllGuru() async {
    try {
      final response = await _apiClient.get('/guru');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Ambil detail guru
  static Future<Map<String, dynamic>> getGuruById(int id) async {
    try {
      final response = await _apiClient.get('/guru/$id');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
