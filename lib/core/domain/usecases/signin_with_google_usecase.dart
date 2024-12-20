import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_delivery_app_user/config/errors/faliure.dart';
import 'package:fuel_delivery_app_user/core/domain/repositories/auth_rempsitory.dart';

abstract class SignInWithGoogleUsecase {
  Future<Either<Failure, UserCredential?>> exicute();
}

class SignInWithGoogleUsecaseImpl {
  AuthRepository authRepository;

  SignInWithGoogleUsecaseImpl({required this.authRepository});
  Future<Either<Failure, UserCredential?>> exicute() {
    return authRepository.signInWithGoogle();
  }
}
