import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient._internal(this.dio);

  static ApiClient? _instance;

  factory ApiClient() {
    _instance ??= ApiClient._internal(Dio());
    _instance?.dio.options.baseUrl = 'https://task_api.com/api';  // Ganti dengan URL API backend kamu
    _instance?.dio.options.headers = {
      'Content-Type': 'application/json',
    };
    _instance?.dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Kamu bisa menambahkan token atau manipulasi request di sini
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Response handling bisa dilakukan di sini
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        // Menangani error
        return handler.next(e);
      },
    ));
    return _instance!;
  }

  Future<Response> get(String path) {
    return dio.get(path);
  }

  Future<Response> post(String path, dynamic data) {
    return dio.post(path, data: data);
  }

  Future<Response> put(String path, dynamic data) {
    return dio.put(path, data: data);
  }

  Future<Response> delete(String path) {
    return dio.delete(path);
  }
}
