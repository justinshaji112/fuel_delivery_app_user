import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDataSorce {
  Future<UserCredential> signUpUser({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await FireSetup.auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await FireSetup.auth.currentUser!.updateDisplayName(name);
      await FireSetup.auth.currentUser!.verifyBeforeUpdateEmail(email);

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> Loginuser(
      {required String email, required String passWord}) async {
    try {
      UserCredential userCredential = await FireSetup.auth
          .signInWithEmailAndPassword(email: email, password: passWord);

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw Exception('User canceled Google sign-in.');
      }

      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      if (googleAuth == null) {
        throw Exception(
            'Error during Google authentication.');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } on PlatformException catch (error) {
      String message =
          'An error occurred during Google sign-in: ${error.message}';
      if (error.code == 'account_exists_with_different_credential') {
        message =
            'The email address is already in use with a different account.';
      }
     rethrow;
    } catch (error) {
      print('Unexpected error during Google sign-in: $error');
      rethrow;
    }
  }

  Future<User?> isLogedIn() async {
    return FireSetup.auth.currentUser;
  }

  Future<void> sendEmailVarification() async {
    try {
      await FireSetup.auth.currentUser!.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    return await FireSetup.auth.signOut();
  }
}
