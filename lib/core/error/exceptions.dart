/// Base exception class for the application.
abstract class AppException implements Exception {
  const AppException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => '$runtimeType(message: $message, statusCode: $statusCode)';
}

/// Thrown when remote API responds with an error status code.
class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode});
}

/// Thrown when connectivity or network timeout occurs.
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection or request timed out.',
    super.statusCode,
  });
}

/// Thrown when local Hive storage fails.
class CacheException extends AppException {
  const CacheException({
    super.message = 'Local cache operation failed.',
    super.statusCode,
  });
}

/// Thrown when GPS or device geocoding fails.
class LocationException extends AppException {
  const LocationException({
    required super.message,
    super.statusCode,
  });
}
