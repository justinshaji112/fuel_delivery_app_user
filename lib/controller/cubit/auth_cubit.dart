import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_delivery_app_user/controller/auth_bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/interface/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo authRepo;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

 void checkLogedIn() async {
    Future.delayed(const Duration(seconds: 1));

    if (await authRepo.isUserLoggedIn()) {
      log("is email verified ${await authRepo.isEmailVerified()}");

      if (!await authRepo.isEmailVerified()) {
        emit(EmailVrification());
        verifyEmail();
      } else {
        emit(AuthSucess());
      }
    } else {
      emit(AuthInitial());
    }
  }

 void singUP(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    emit(AuthLoading());
    try {
      await authRepo.signUp(email, password, phone, name);
      emit(EmailVrification());
      verifyEmail();
    } catch (e) {
      emit(AuthFaild(message: e.toString()));
    }
  }

 void signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await authRepo.signIn(email, password);
      checkLogedIn();
    } catch (e) {
      emit(AuthFaild(message: e.toString()));
    }
  }

 void signOut() async {
    emit(AuthLoading());
    try {
      await authRepo.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFaild(message: e.toString()));
    }
  }

 void signInWithGoogle() async {
    emit(AuthLoading());
    try {
      await authRepo.signinWithGoogle();
      emit(AuthSucess());
    } catch (e) {
      emit(AuthFaild(message: e.toString()));
    }
  }

 void verifyEmail() async {
    try {
      await authRepo.sendVerificationEmail();
      Timer.periodic(const Duration(seconds: 2), (timer) async {
        log(timer.tick.toString());
        if (timer.tick == 30) {
          timer.cancel();
        }
        log("timear starts");
        bool isVerified = await authRepo.isEmailVerified();
        log(isVerified.toString());
        if (isVerified) {
          emit(AuthSucess());
          timer.cancel();
        }
      });
    } catch (e) {
      emit(AuthFaild(message: e.toString()));
    }
  }

 void sendVerificationEmail() async {
    try {
      // emit(AuthLoading());
      await authRepo.sendVerificationEmail();
    } catch (e) {
      emit(AuthFaild(message: e.toString()));
    }
  }

  @override
  void onChange(Change<AuthState> change) {



    // TODO: implement onChange
    super.onChange(change);

    print(change);
    log(
      change.toString(),
    );
  }
 
 void resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await authRepo.resetPassword(email);
      emit(PasswordResetEmailSent());
    } catch (e) {
      emit(AuthFaild(message: e.toString()));
    }
  }

}
