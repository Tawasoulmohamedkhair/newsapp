import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:newsapp/core/error/dio_error_mapper.dart';
import 'package:newsapp/core/utils/app_logger.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

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
    final failure = DioErrorMapper.map(err);

    if (kDebugMode) {
      AppLogger.error('''
❌ ERROR
→ TYPE: ${err.type}
→ MESSAGE: ${failure.message}
→ URL: ${err.requestOptions.uri}
→ RESPONSE: ${err.response?.data}
''');
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: failure,
        type: err.type,
        response: err.response,
      ),
    );
  }
}
