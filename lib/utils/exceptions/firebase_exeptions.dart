class AppFirebaseExeption implements Exception{
final String message;
  const AppFirebaseExeption([this.message = "An unknown error occurred."]);
 @override
  String toString() {
    // TODO: implement toString
    return message;

  }
  factory AppFirebaseExeption.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const AppFirebaseExeption('Email already exists');
      case 'invalid-email':
        return const AppFirebaseExeption('Email is not valid');
      case 'weak-password':
        return const AppFirebaseExeption('Please enter a stronger password');
      case 'user-disabled':
        return const AppFirebaseExeption('This user has been disabled');
      case 'user-not-found':
        return const AppFirebaseExeption('User not found');
      case 'wrong-password':
        return const AppFirebaseExeption('Incorrect password');
      case 'operation-not-allowed':
        return const AppFirebaseExeption('Operation not allowed');
      case 'too-many-requests':
        return const AppFirebaseExeption('Too many requests. Try again later');
      case 'network-request-failed':
        return const AppFirebaseExeption('Network error occurred');
      case 'invalid-credential':
        return const AppFirebaseExeption('Invalid credentials');
      case 'account-exists-with-different-credential':
        return const AppFirebaseExeption('Account exists with different credentials');
      case 'invalid-verification-code':
        return const AppFirebaseExeption('Invalid verification code');
      case 'invalid-verification-id':
        return const AppFirebaseExeption('Invalid verification ID');
      case 'expired-action-code':
        return const AppFirebaseExeption('Code has expired');
      case 'invalid-action-code':
        return const AppFirebaseExeption('Invalid code');
      case 'missing-action-code':
        return const AppFirebaseExeption('Code is missing');
      case 'user-token-expired':
        return const AppFirebaseExeption('User token has expired');
      case 'invalid-custom-token':
        return const AppFirebaseExeption('Invalid custom token');
      case 'custom-token-mismatch':
        return const AppFirebaseExeption('Custom token mismatch');
      case 'invalid-continue-uri':
        return const AppFirebaseExeption('Invalid continue URI');
      case 'missing-continue-uri':
        return const AppFirebaseExeption('Continue URI is missing');
      case 'invalid-dynamic-link-domain':
        return const AppFirebaseExeption('Invalid dynamic link domain');
      case 'invalid-phone-number':
        return const AppFirebaseExeption('Invalid phone number');
      case 'missing-phone-number':
        return const AppFirebaseExeption('Phone number is missing');
      case 'quota-exceeded':
        return const AppFirebaseExeption('Quota exceeded');
      case 'session-expired':
        return const AppFirebaseExeption('Session has expired');
      case 'app-not-authorized':
        return const AppFirebaseExeption('App not authorized');
      case 'captcha-check-failed':
        return const AppFirebaseExeption('Captcha check failed');
      case 'web-context-cancelled':
        return const AppFirebaseExeption('Web operation cancelled');
      case 'web-storage-unsupported':
        return const AppFirebaseExeption('Web storage unsupported');
      default:
        return const AppFirebaseExeption('An unknown error occurred');
    }
  }
}





