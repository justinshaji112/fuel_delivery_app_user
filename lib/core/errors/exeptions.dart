class ServerException implements Exception {}


// Custom exception classes for specific error scenarios
class SignInCanceledException implements Exception {
  final String message;

  SignInCanceledException(this.message);
}

class SignInAuthenticationException implements Exception {
  final String message;

  SignInAuthenticationException(this.message);
}

class SignInException implements Exception {
  final String message;

  SignInException(this.message);
}