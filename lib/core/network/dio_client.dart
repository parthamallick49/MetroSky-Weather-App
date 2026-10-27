import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

/// Configured [Dio] HTTP client singleton with timeout, retry, and error interceptors.
class DioClient {
  DioClient({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: <String, dynamic>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    _dio.interceptors.addAll([
      RetryInterceptor(dio: _dio),
      ErrorInterceptor(),
    ]);
  }

  final Dio _dio;

  Dio get instance => _dio;

  /// Convenience GET method.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}

/// Global provider for [DioClient].
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});
