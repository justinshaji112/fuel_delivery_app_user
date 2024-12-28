import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_delivery_app_user/config/errors/faliure.dart';
import 'package:fuel_delivery_app_user/core/data/models/auth_model.dart';
import 'package:fuel_delivery_app_user/core/domain/entities/user_entitiy.dart';

abstract class AuthRepository {
  Future<bool> createAccountWithPhoneNumber({
    UserModel userdata,
  });
  Future<Either<Failure, UserCredential>> signUpWithEmail({
    required UserEntity user,
  });
  Future<Either<Failure, bool>> saveUserData({
    required String uid,
    required String email,
    required String phoneNumber,
    required String displayName,
  });

  Future<Either<Failure, UserCredential>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Stream<User?> get currentUser;
  Future<void> sendEmailVarification();
  Future<bool> isEmailVaryfied();

  Future<User?> isLogedIn();
  Future<void> logOut();
  Future<Either<Failure,UserCredential?>> signInWithGoogle();
}
