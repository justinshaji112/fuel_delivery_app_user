part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFaild extends AuthState {
 final String message;

  AuthFaild({required this.message});
}

final class AuthSucess extends AuthState {}
final class EmailVrification extends AuthState {}
