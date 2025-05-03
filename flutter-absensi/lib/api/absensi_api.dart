import 'package:dio/dio.dart';
import 'api_client.dart';

class AbsensiApi {
  static final _apiClient = ApiClient();

  // Ambil data absensi
  static Future<List<dynamic>> getAllAbsensi() async {
    try {
      final response = await _apiClient.get('/absensi');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Tambah data absensi
  static Future<Map<String, dynamic>> addAbsensi(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.post('/absensi', data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Ambil absensi berdasarkan ID
  static Future<Map<String, dynamic>> getAbsensiById(int id) async {
    try {
      final response = await _apiClient.get('/absensi/$id');
      return response.data;
    } catch (e)      {
      rethrow;
    }
  }
}
