import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final logger = Logger(printer: PrettyPrinter(printEmojis: false));

const _jsonEncoder = JsonEncoder.withIndent('  ');

String _prettyJson(dynamic data) {
  try {
    return _jsonEncoder.convert(data);
  } catch (_) {
    return data.toString();
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    logger.d('---> ${options.method} ${options.uri}');
    logger.d('Headers: ${options.headers}');
    logger.d('---> END ${options.method}');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    logger.i('<--- HTTP CODE: ${response.statusCode} URL: ${response.realUri}');
    logger.d('Response:\n${_prettyJson(response.data)}');
    logger.d('<--- END HTTP');
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    logger.e('<--- ERROR', error: err.message);
    logger.e('Type: ${err.type}');
    if (err.response != null) {
      logger.e('Status Code: ${err.response?.statusCode}');
      logger.e('Response:\n${_prettyJson(err.response?.data)}');
    }
    logger.e('<--- END ERROR');
  }
}
