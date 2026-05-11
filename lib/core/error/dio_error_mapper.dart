import 'package:dio/dio.dart';
import 'package:newsapp/core/error/failure.dart';

class DioErrorMapper {
  static Failure map(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure("Request timeout, try again.");

      case DioExceptionType.connectionError:
        return NetworkFailure("No internet connection.");

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);

      case DioExceptionType.cancel:
        return UnknownFailure("Request was cancelled.");

      default:
        return UnknownFailure("Unexpected error occurred.");
    }
  }

  static Failure _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return ServerFailure("Bad request.");
      case 401:
        return ServerFailure("Unauthorized.");
      case 403:
        return ServerFailure("Forbidden.");
      case 404:
        return ServerFailure("Not found.");
      case 500:
        return ServerFailure("Server error.");
      default:
        return ServerFailure("Something went wrong.");
    }
  }
}
