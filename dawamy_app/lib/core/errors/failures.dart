abstract class Failure {
  final String message;
  final int? code;

  const Failure({this.message = 'An unexpected error occurred', this.code});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred', super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred', super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection', super.code});
}

class AuthFailure extends Failure {
  const AuthFailure({super.message = 'Authentication failed', super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure({super.message = 'Validation failed', super.code});
}

class PremiumFeatureFailure extends Failure {
  const PremiumFeatureFailure({
    super.message = 'This feature is only available on the Pro plan',
    super.code,
  });
}

class SyncFailure extends Failure {
  const SyncFailure({super.message = 'Sync failed', super.code});
}
