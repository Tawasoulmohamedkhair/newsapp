import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:newsapp/core/utils/app_logger.dart';

class DioLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      AppLogger.info('''
🚀 REQUEST
→ METHOD: ${options.method}
→ URL: ${options.uri}
→ HEADERS: ${options.headers}
→ DATA: ${options.data}
''');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      AppLogger.info('''
✅ RESPONSE
→ STATUS: ${response.statusCode}
→ URL: ${response.requestOptions.uri}
→ DATA: ${response.data}
''');
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      AppLogger.error('''
❌ ERROR
→ TYPE: ${err.type}
→ MESSAGE: ${err.message}
→ URL: ${err.requestOptions.uri}
→ RESPONSE: ${err.response?.data}
''');
    }

    super.onError(err, handler);
  }
}
