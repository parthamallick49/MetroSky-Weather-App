import 'dart:io';
import 'package:dio/dio.dart';
import '../../error/exceptions.dart';

/// Interceptor mapping [DioException] to domain [AppException] subtypes.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final mappedException = _mapDioException(err);
    return handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: mappedException,
        message: mappedException.message,
      ),
    );
  }

  AppException _mapDioException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.transformTimeout:
        return const NetworkException(
          message: 'Connection timed out. Please check your internet connectivity.',
        );

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final responseData = err.response?.data;
        String message = 'Server returned error status code: $statusCode';

        if (responseData is Map<String, dynamic>) {
          if (responseData['reason'] != null) {
            message = responseData['reason'].toString();
          } else if (responseData['message'] != null) {
            message = responseData['message'].toString();
          } else if (responseData['error'] == true && responseData['reason'] != null) {
            message = responseData['reason'].toString();
          }
        }

        return ServerException(message: message, statusCode: statusCode);

      case DioExceptionType.cancel:
        return const NetworkException(message: 'Request was cancelled.');

      case DioExceptionType.badCertificate:
        return const NetworkException(message: 'Invalid server security certificate.');

      case DioExceptionType.unknown:
        if (err.error is SocketException) {
          return const NetworkException(
            message: 'Unable to reach the weather servers. Please verify your connection.',
          );
        }
        return ServerException(
          message: err.message ?? 'An unexpected network error occurred.',
          statusCode: err.response?.statusCode,
        );
    }
  }
}
