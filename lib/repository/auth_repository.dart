import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuel_delivery_app_user/interface/repository/auth_repo.dart';
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/utils/exceptions/firebase_auth_exeption.dart';
import 'package:fuel_delivery_app_user/utils/exceptions/firebase_exeptions.dart';
import 'package:fuel_delivery_app_user/utils/exceptions/formate_exeptions.dart';
import 'package:fuel_delivery_app_user/utils/exceptions/unknow_exettions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<void> signUp(
      String email, String password, String phone, String name) async {
    try {
      await FireSetup.auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await FireSetup.users.doc(FireSetup.auth.currentUser!.uid).set({
        'email': email,
        'phoneNumber': phone,
        'name': name,
      });
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExeption.fromCode(e.code);
    } on FirebaseException catch (e) {
      throw AppFirebaseExeption.fromCode(e.code);
    } on FormatException catch (e) {
      throw AppFormatException.fromCode(e.message);
    } on Exception catch (e) {
      throw AppUnknownException(e.toString());
    }
  }

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      await FireSetup.auth
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExeption.fromCode(e.code);
    } on FirebaseException catch (e) {
      throw AppFirebaseExeption.fromCode(e.code);
    } on FormatException catch (e) {
      throw AppFormatException.fromCode(e.message);
    } on Exception catch (e) {
      throw AppUnknownException(e.toString());
    }
  }

  @override
  Future<bool> signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw Exception('User canceled Google sign-in.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FireSetup.auth.signInWithCredential(credential);
      await FireSetup.users.doc(FireSetup.auth.currentUser!.uid).set({
        'email': googleUser.email,
        'phoneNumber': googleUser.id,
        'name': googleUser.displayName,
      });

      return true;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExeption.fromCode(e.code);
    } on FirebaseException catch (e) {
      throw AppFirebaseExeption.fromCode(e.code);
    } on FormatException catch (e) {
      throw AppFormatException.fromCode(e.message);
    } on Exception catch (e) {
      throw AppUnknownException(e.toString());
    }
  }

  @override
  Future<bool> verifyEmail(String email) async {
    try {
      await FireSetup.auth.currentUser!.verifyBeforeUpdateEmail(email);
      return true;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExeption.fromCode(e.code);
    } on FirebaseException catch (e) {
      throw AppFirebaseExeption.fromCode(e.code);
    } on FormatException catch (e) {
      throw AppFormatException.fromCode(e.message);
    } on Exception catch (e) {
      throw AppUnknownException(e.toString());
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    try {
      await FireSetup.auth.currentUser!.reload();
      return FireSetup.auth.currentUser?.emailVerified ?? false;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExeption.fromCode(e.code);
    } on FirebaseException catch (e) {
      throw AppFirebaseExeption.fromCode(e.code);
    } on FormatException catch (e) {
      throw AppFormatException.fromCode(e.message);
    } on Exception catch (e) {
      throw AppUnknownException(e.toString());
    }
  }

  @override
  Future<bool> sendVerificationEmail() async {
    try {
      await FireSetup.auth.currentUser!.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExeption.fromCode(e.code);
    } on FirebaseException catch (e) {
      throw AppFirebaseExeption.fromCode(e.code);
    } on FormatException catch (e) {
      throw AppFormatException.fromCode(e.message);
    } on Exception catch (e) {
      throw AppUnknownException(e.toString());
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      await FireSetup.auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExeption.fromCode(e.code);
    } on FirebaseException catch (e) {
      throw AppFirebaseExeption.fromCode(e.code);
    } on FormatException catch (e) {
      throw AppFormatException.fromCode(e.message);
    } on Exception catch (e) {
      throw AppUnknownException(e.toString());
    }
  }

  @override
  Future<bool> isPasswordResetEmailSent() async {
    try {
      return FireSetup.auth.currentUser!.emailVerified;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExeption.fromCode(e.code);
    } on FirebaseException catch (e) {
      throw AppFirebaseExeption.fromCode(e.code);
    } on FormatException catch (e) {
      throw AppFormatException.fromCode(e.message);
    } on Exception catch (e) {
      throw AppUnknownException(e.toString());
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      return FireSetup.auth.currentUser?.emailVerified ?? false;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExeption.fromCode(e.code);
    } on FirebaseException catch (e) {
      throw AppFirebaseExeption.fromCode(e.code);
    } on FormatException catch (e) {
      throw AppFormatException.fromCode(e.message);
    } on Exception catch (e) {
      throw AppUnknownException(e.toString());
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await FireSetup.auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthExeption.fromCode(e.code);
    } on FirebaseException catch (e) {
      throw AppFirebaseExeption.fromCode(e.code);
    } on FormatException catch (e) {
      throw AppFormatException.fromCode(e.message);
    } on Exception catch (e) {
      throw AppUnknownException(e.toString());
    }
  }
}
