// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginButtonPressedEvent({required this.email, required this.password});
}

class SignUpButtonPressedEvent extends AuthEvent {
  final UserModel user;
  const SignUpButtonPressedEvent({required this.user});
}

class GoToSingUPPageEvent extends AuthEvent {}

class GoToLoginPageEvent extends AuthEvent {}

class VerifyButtonPressedEvent extends AuthEvent {
  
  

}

class ResentValidationEvent extends AuthEvent {}

class LogoutPressedEvent extends AuthEvent {}

class GoogleSingInEvent extends AuthEvent {}

class CheckLoginEvent extends AuthEvent {}
