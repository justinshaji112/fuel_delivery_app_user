import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel_delivery_app_user/repository/auth_datasorce.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthDataSorce authDataSorce = AuthDataSorce();
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<LoginEvent>((event, emit) {
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        try {
          authDataSorce.Loginuser(email: event.email, passWord: event.password);
          emit(AuthSucess());
        } catch (e) {
          emit(AuthFaild(message: e.toString()));
        }
      }
      emit(AuthFaild(message: "Enter Username and Password"));
    });

    on<GoogleLoginEvent>(
      (event, emit) {
        try {
          authDataSorce.signInWithGoogle();
          emit(AuthSucess());
        } catch (e) {
          emit(AuthFaild(message: e.toString()));
        }
      },
    );

    on<SignUpEvent>(
      (event, emit) {
        if (event.email.isNotEmpty &&
            event.password.isNotEmpty &&
            event.phone.isNotEmpty &&
            event.name.isNotEmpty) {
          try {
            authDataSorce.signUpUser(
                email: event.email,
                password: event.password,
                phone: event.phone,
                name: event.name);
            emit(EmailVrification());
          } catch (e) {
            emit(AuthFaild(message: e.toString()));
          }
        }
      },
    );
  }
}
