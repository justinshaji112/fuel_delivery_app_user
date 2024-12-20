import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_delivery_app_user/config/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/config/errors/faliure.dart';
import 'package:fuel_delivery_app_user/core/data/datasources/save_user.dart';
import 'package:fuel_delivery_app_user/core/data/datasources/auth_datasorce.dart';
import 'package:fuel_delivery_app_user/core/data/models/auth_model.dart';
import 'package:fuel_delivery_app_user/core/domain/entities/user_entitiy.dart';
import 'package:fuel_delivery_app_user/core/domain/repositories/auth_rempsitory.dart';

class AuthRepositryImpl implements AuthRepository {
  AuthDataSorce authDataSorce;

  AuthRepositryImpl({required this.authDataSorce});

  @override
  Future<Either<Failure, bool>> saveUserData(
      {required String uid,
      required String email,
      required String phoneNumber,
      required String displayName}) async {
    try {
      ScveUserDataSorece.saveUser(
          name: displayName, email: email, phone: phoneNumber, uid: uid);
      return const Right(true);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<bool> createAccountWithPhoneNumber({UserModel? userdata}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> signUpWithEmail(
      {required UserEntity user}) async {
    try {
      UserCredential userCredential = await authDataSorce.signUpUser(
          email: user.email,
          password: user.password,
          phone: user.phoneNumber,
          name: user.name);

      return Right(userCredential);
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        return const Left(
            WeakPasswordFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        return const Left(UserAlradyExistFailure(
            'The account already exists for that email.'));
      } else if (e.code == 'invalid-email') {
        return const Left(
            InvalidEmailFailure('The email address is not valid.'));
      } else {
        return Left(UnknownFailure(e.message.toString()));
      }
    } catch (e) {
      return const Left(UnknownFailure("unknow error occured"));
    }
  }

  @override
  Stream<User?> get currentUser =>
      FireSetup.auth.authStateChanges().map((firebaseUser) {
        return FireSetup.auth.currentUser;
      });

  @override
  Future<bool> isEmailVaryfied() async {
    await FireSetup.auth.currentUser!.reload();
    final user = FireSetup.auth.currentUser;

    return user!.emailVerified ? true : false;
  }

  @override
  Future<void> sendEmailVarification() async {
    await authDataSorce.sendEmailVarification();
  }

  @override
  Future<User?> isLogedIn() async {
    return authDataSorce.isLogedIn();
  }

  @override
  Future<void> logOut() {
    return authDataSorce.logOut();
  }

  @override
  Future<Either<Failure, UserCredential>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await authDataSorce.Loginuser(email: email, passWord: password);

      return Right(userCredential);
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        return const Left(
            WeakPasswordFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        return const Left(UserAlradyExistFailure(
            'The account already exists for that email.'));
      } else if (e.code == 'invalid-email') {
        return const Left(
            InvalidEmailFailure('The email address is not valid.'));
      } else {
        return Left(UnknownFailure('An unknown error occurred'));
      }
    } catch (e) {
      return Left(UnknownFailure('An unknown error occurred'));

      // return Left((e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> signInWithGoogle() async {
    try {
      final credintial = await authDataSorce.signInWithGoogle();
      return Right(credintial);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
