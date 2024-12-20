import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_delivery_app_user/config/errors/faliure.dart';
import 'package:fuel_delivery_app_user/core/domain/repositories/auth_rempsitory.dart';

abstract class SignInUsecase {
  Future<Either<Failure, UserCredential>> exicute(
      {required String email, required String password});
}

class SignInUsecaseImpl extends SignInUsecase {
  AuthRepository authRepository;

  SignInUsecaseImpl({required this.authRepository});
  Future<Either<Failure, UserCredential>> exicute(
      {required String email, required String password}) async {
    return await authRepository.logInWithEmailAndPassword(
        email: email, password: password);
  }
}
