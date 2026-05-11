import 'package:dio/dio.dart';
import 'package:newsapp/core/constant/apiconfig.dart';

class ApiService {
  
  final Dio dio;

  ApiService(this.dio);


  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await dio.get(
        '/v2/$endpoint',
        queryParameters: {'apiKey': ApiConfig.apikey, ...?params},
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      return e.response?.data.toString() ?? 'Server Error';
    } else {
      return e.message ?? 'Network Error';
    }
  }
}
