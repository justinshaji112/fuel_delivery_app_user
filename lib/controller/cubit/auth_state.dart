part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}
final class PasswordResetEmailSent extends AuthState {}

final class AuthSucess extends AuthState {}

final class AuthFaild extends AuthState {
  final String message;
  const AuthFaild({required this.message});
}


final class EmailSent extends AuthState {}
final class EmailVrification extends AuthState {}

final class GoogleVrification extends AuthState {}
