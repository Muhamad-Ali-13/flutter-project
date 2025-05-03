import 'package:dio/dio.dart';
import 'api_client.dart';

class SiswaApi {
  static final _apiClient = ApiClient();

  // Ambil daftar siswa
  static Future<List<dynamic>> getAllSiswa() async {
    try {
      final response = await _apiClient.get('/siswa');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Ambil detail siswa
  static Future<Map<String, dynamic>> getSiswaById(int id) async {
    try {
      final response = await _apiClient.get('/siswa/$id');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Tambah siswa baru
  static Future<Map<String, dynamic>> addSiswa(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.post('/siswa', data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
