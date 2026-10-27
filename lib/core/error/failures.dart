/// Base sealed class for all application failures.
sealed class AppFailure {
  const AppFailure({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => '$runtimeType(message: $message, statusCode: $statusCode)';
}

/// Remote API or server error (e.g., 500, 502, 400).
final class ServerFailure extends AppFailure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Network connectivity, DNS resolution, or timeout failures.
final class NetworkFailure extends AppFailure {
  const NetworkFailure({
    super.message = 'Please check your internet connection and try again.',
    super.statusCode,
  });
}

/// Local storage / Hive cache read-write failures.
final class CacheFailure extends AppFailure {
  const CacheFailure({
    super.message = 'Unable to access local cached data.',
    super.statusCode,
  });
}

/// Location service permission denied or disabled failures.
final class LocationFailure extends AppFailure {
  const LocationFailure({
    required super.message,
    super.statusCode,
  });
}

/// Unhandled or unexpected exceptions.
final class UnknownFailure extends AppFailure {
  const UnknownFailure({
    super.message = 'An unexpected error occurred. Please try again.',
    super.statusCode,
  });
}
