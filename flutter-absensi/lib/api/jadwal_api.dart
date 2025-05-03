import 'package:dio/dio.dart';
import 'api_client.dart';

class JadwalApi {
  static final _apiClient = ApiClient();

  // Ambil semua jadwal
  static Future<List<dynamic>> getAllJadwal() async {
    try {
      final response = await _apiClient.get('/jadwal');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Ambil jadwal berdasarkan ID
  static Future<Map<String, dynamic>> getJadwalById(int id) async {
    try {
      final response = await _apiClient.get('/jadwal/$id');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
