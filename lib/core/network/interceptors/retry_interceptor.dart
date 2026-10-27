import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

/// Interceptor that retries failed requests with exponential backoff.
/// Targets connection timeouts, send/receive timeouts, and 5xx server errors.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.initialBackoff = const Duration(milliseconds: 500),
  });

  final Dio dio;
  final int maxRetries;
  final Duration initialBackoff;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = Map<String, dynamic>.from(err.requestOptions.extra);
    final retryCount = (extra['retry_count'] as int?) ?? 0;

    if (_shouldRetry(err) && retryCount < maxRetries) {
      extra['retry_count'] = retryCount + 1;
      err.requestOptions.extra = extra;

      // Exponential backoff: backoff * 2^(retryCount)
      final backoff = initialBackoff * (1 << retryCount);
      await Future<void>.delayed(backoff);

      try {
        final response = await dio.fetch<dynamic>(err.requestOptions);
        return handler.resolve(response);
      } on DioException catch (retryErr) {
        return super.onError(retryErr, handler);
      }
    }

    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.error is SocketException) ||
        (err.response != null && (err.response!.statusCode ?? 0) >= 500);
  }
}
