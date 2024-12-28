import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}

class WeakPasswordFailure extends Failure {
  const WeakPasswordFailure(String message) : super(message);
}

class InvalidEmailFailure extends Failure {
  const InvalidEmailFailure(String message) : super(message);
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure(String message) : super(message);
}
class UserAlradyExistFailure extends Failure {
  const UserAlradyExistFailure(String message) : super(message);
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure(String message) : super(message);
}

class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure(String message) : super(message);
}

class NetworkRequestFailedFailure extends Failure {
  const NetworkRequestFailedFailure(String message) : super(message);
}

class AccountExistsWithDifferentCredentialFailure extends Failure {
  const AccountExistsWithDifferentCredentialFailure(String message) : super(message);
}

class OperationNotAllowedFailure extends Failure {
  const OperationNotAllowedFailure(String message) : super(message);
}

class InvalidCredentialFailure extends Failure {
  const InvalidCredentialFailure(String message) : super(message);
}
class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message);
}
