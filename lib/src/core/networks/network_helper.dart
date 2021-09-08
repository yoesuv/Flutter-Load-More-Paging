import 'package:bloc_load_more/src/core/data/constants.dart';
import 'package:bloc_load_more/src/core/networks/logging_interceptor.dart';
import 'package:dio/dio.dart';

class NetworkHelper {

  NetworkHelper() {
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: TIME_OUT,
      sendTimeout: TIME_OUT,
      receiveTimeout: TIME_OUT,
    ));
    _dio.interceptors.add(LoggingInterceptor());
  }

  late Dio _dio;

  Future<dynamic> get(String url) async {
    dynamic response;
    try {
      response = await _dio.get<dynamic>(url);
    } catch (err) {
      rethrow;
    }
    return response;
  }

}