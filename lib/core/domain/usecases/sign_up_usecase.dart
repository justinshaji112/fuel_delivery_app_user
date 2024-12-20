// ignore_for_file: unused_import

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_delivery_app_user/config/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/config/errors/faliure.dart';
import 'package:fuel_delivery_app_user/core/data/models/auth_model.dart';
import 'package:fuel_delivery_app_user/core/domain/repositories/auth_rempsitory.dart';

abstract class SignUpUsecase {
  Future<Either<Failure, UserCredential>> execute(
      {required UserModel userdata});
}

class SignUpUsecaseImpl extends SignUpUsecase {
  final AuthRepository userRepository;

  SignUpUsecaseImpl({required this.userRepository});
  @override
  Future<Either<Failure, UserCredential>> execute(
      {required UserModel userdata}) async {
    Either<Failure, UserCredential> userCreated =
        await userRepository.signUpWithEmail(user: userdata);

    return userCreated;
  }
}
