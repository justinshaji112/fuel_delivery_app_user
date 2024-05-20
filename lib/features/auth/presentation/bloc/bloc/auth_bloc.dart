import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_delivery_app_user/features/auth/data/models/auth_model.dart';
import 'package:fuel_delivery_app_user/features/auth/domain/usecases/check_sign_in_usecase.dart';
import 'package:fuel_delivery_app_user/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:fuel_delivery_app_user/features/auth/domain/usecases/signin_usecase.dart';
import 'package:fuel_delivery_app_user/features/auth/domain/usecases/signin_with_google_usecase.dart';
import 'package:fuel_delivery_app_user/features/auth/domain/usecases/saveuser_data_usecase.dart';
import 'package:fuel_delivery_app_user/features/auth/domain/usecases/send_verification_email.dart';
import 'package:fuel_delivery_app_user/features/auth/domain/usecases/sign_up_usecase.dart';
import '../../../domain/usecases/check_email_veryfied_usecase.dart';
import '../../../../../core/errors/faliure.dart';
import '../../../domain/usecases/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SignUpUsecaseImpl signUpUsecase;
  SaveUserDataUsecaseImpl saveUserDataUseCase;
  SignInWithGoogleUsecaseImpl singInWithGoole;
  SendVerificationEmaileUsecaseImpl sendVerificationEmail;
  SingOutUsecaseImpl singOutUsecase;
  CheckSignInUsecaseImpl checkSignInnUsecase;
  CheckEmailVerifiedUsecaseImpl checkEmailVerified;
  SignInUsecaseImpl signInUsecase;

  AuthBloc(
      {required this.saveUserDataUseCase,
      required this.signUpUsecase,
      required this.checkEmailVerified,
      required this.checkSignInnUsecase,
      required this.sendVerificationEmail,
      required this.signInUsecase,
      required this.singInWithGoole,
      required this.singOutUsecase})
      : super(AuthInitial()) {
    on<CheckLoginEvent>(
      (event, emit) async {
        final User? isSignedIn = await checkSignInnUsecase.exicute();
        if (isSignedIn!=null) {
          emit(AlradySignInedState());
        } else if (isSignedIn==null){
          emit(UserNeverSingedState());
        }
      },
    );

    on<AuthEvent>((event, emit) {});
    on<SingUpButtonPressedEvent>((event, emit) => singUP(
        checkEmailVerifiedUsecase: checkEmailVerified,
        sendVerificationEmail: sendVerificationEmail,
        signUpUsecase: signUpUsecase,
        emit: emit,
        event: event,
        saveUserDataUseCase: saveUserDataUseCase));
    on<VerifyButtonPressedEvent>((event, emit) async {
      bool a = await checkEmailVerified.exicute();
      if (a) {
        emit(EmailVaryfiedState());
      } else {
        emit(EmailVarificationFailedState());
      }
    });

    on<LogoutPressedEvent>((event, emit) async {
      await singOutUsecase.exicute();
      emit(LogOutState());
    });
    on<LoginButtonPressedEvent>((event, emit) async {
      Either<Failure, UserCredential> longinCredential = await signInUsecase
          .exicute(email: event.email, password: event.password);

      longinCredential.fold((l) => emit(LoginErrorState(err: l.toString())),
          (r) => emit(LoginState()));
    });
    on<GoogleSingInEvent>((event, emit) async {
      try {
        singInWithGoole.exicute();
        emit(LoginState());
      } catch (e) {
        emit(LoginErrorState(err: e.toString()));
        emit(AuthInitial());
      }
    });
  }
}

singUP(
    {required CheckEmailVerifiedUsecaseImpl checkEmailVerifiedUsecase,
    required SignUpUsecaseImpl signUpUsecase,
    required SendVerificationEmaileUsecaseImpl sendVerificationEmail,
    required Emitter<AuthState> emit,
    required SingUpButtonPressedEvent event,
    required SaveUserDataUseCase saveUserDataUseCase}) async {
  Either<Failure, UserCredential> singUpCredential =
      await signUpUsecase.execute(userdata: event.user);
  singUpCredential.fold((l) {
    return emit(SingnUpFaildState(err: l.toString()));
  }, (r) async {
    emit(SignUpSucessState());
    await sendVerificationEmail.exicute();
    emit(VarificationEmailSendState());

    Timer.periodic(Duration(seconds: 3), (timer) async {
      bool a = await checkEmailVerifiedUsecase.exicute();
      if (a) {
        emit(EmailVaryfiedState());
        timer.cancel();
      }
    });

    await saveUserDataUseCase.exicute(user: event.user, uid: r.user!.uid);
  });
}
