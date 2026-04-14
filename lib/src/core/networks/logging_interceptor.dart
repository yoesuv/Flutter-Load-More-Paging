import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    debugPrint('\n\n---> ${options.method} ${options.uri}');
    debugPrint('Headers: ${options.headers}');
    debugPrint('---> END ${options.method}');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    debugPrint('\n\n');
    debugPrint(
      '<--- HTTP CODE : ${response.statusCode} URL : ${response.realUri.toString()}',
    );
    debugPrint('Headers: ');
    printWrapped('Response : ${response.data}');
    debugPrint('<--- END HTTP');
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    debugPrint('\n\n<--- ERROR');
    debugPrint('Type: ${err.type}');
    debugPrint('Message: ${err.message}');
    if (err.response != null) {
      debugPrint('Status Code: ${err.response?.statusCode}');
      debugPrint('Response: ${err.response?.data}');
    }
    debugPrint('<--- END ERROR');
  }

  void printWrapped(String text) {
    final RegExp pattern = RegExp('.{1,800}');
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => debugPrint(match.group(0)));
  }
}
