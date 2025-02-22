// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String phone;
  final String name;
  
  const SignUpEvent({
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
  });
}

class GoogleLoginEvent extends AuthEvent {}

class VerifyEmailEvent extends AuthEvent {}
