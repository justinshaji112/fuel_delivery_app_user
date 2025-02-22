class AppFirebaseAuthExeption implements Exception {
  final String message;
  const AppFirebaseAuthExeption([this.message = "Something went wrong."]);
  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
  factory AppFirebaseAuthExeption.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const AppFirebaseAuthExeption('Invalid email address');
      case 'wrong-password':
        return const AppFirebaseAuthExeption('Wrong password');
      case 'user-not-found':
        return const AppFirebaseAuthExeption('User not found');
      case 'user-disabled':
        return const AppFirebaseAuthExeption('User account has been disabled');
      case 'too-many-requests':
        return const AppFirebaseAuthExeption('Too many requests');
      case 'email-already-in-use':
        return const AppFirebaseAuthExeption('Email already in use');
      case 'operation-not-allowed':
        return const AppFirebaseAuthExeption('Operation not allowed');
      case 'weak-password':
        return const AppFirebaseAuthExeption('Password is too weak');
      case 'account-exists-with-different-credential':
        return const AppFirebaseAuthExeption('Account exists with different credential');
      case 'invalid-credential':
        return const AppFirebaseAuthExeption('Invalid credential');
      case 'invalid-verification-code':
        return const AppFirebaseAuthExeption('Invalid verification code');
      case 'invalid-verification-id':
        return const AppFirebaseAuthExeption('Invalid verification ID');
      case 'invalid-phone-number':
        return const AppFirebaseAuthExeption('Invalid phone number');
      case 'missing-phone-number':
        return const AppFirebaseAuthExeption('Missing phone number');
      case 'missing-verification-code':
        return const AppFirebaseAuthExeption('Missing verification code');
      case 'missing-verification-id':
        return const AppFirebaseAuthExeption('Missing verification ID');
      case 'missing-verification-id-and-code':
        return const AppFirebaseAuthExeption('Missing verification ID and code');
      case 'missing-verification-id-and-phone-number':
        return const AppFirebaseAuthExeption('Missing verification ID and phone number');
      case 'missing-verification-code-and-phone-number':
        return const AppFirebaseAuthExeption('Missing verification code and phone number');
      case 'network-request-failed':
        return const AppFirebaseAuthExeption('Network request failed');
      case 'popup-blocked':
        return const AppFirebaseAuthExeption('Popup blocked');
      case 'popup-closed-by-user':
        return const AppFirebaseAuthExeption('Popup closed by user');
      case 'provider-already-linked':
        return const AppFirebaseAuthExeption('Provider already linked');
      case 'credential-already-in-use':
        return const AppFirebaseAuthExeption('Credential already in use');
      case 'requires-recent-login':
        return const AppFirebaseAuthExeption('Requires recent login');
      case 'session-expired':
        return const AppFirebaseAuthExeption('Session expired');
      case 'quota-exceeded':
        return const AppFirebaseAuthExeption('Quota exceeded');
      case 'cancelled':
        return const AppFirebaseAuthExeption('Operation cancelled');
      case 'dynamic-link-not-activated':
        return const AppFirebaseAuthExeption('Dynamic link not activated');
      case 'expired-action-code':
        return const AppFirebaseAuthExeption('Expired action code');
      case 'invalid-action-code':
        return const AppFirebaseAuthExeption('Invalid action code');
      case 'invalid-continue-uri':
        return const AppFirebaseAuthExeption('Invalid continue URI');
      case 'missing-continue-uri':
        return const AppFirebaseAuthExeption('Missing continue URI');
      case 'invalid-custom-token':
        return const AppFirebaseAuthExeption('Invalid custom token');
      case 'custom-token-mismatch':
        return const AppFirebaseAuthExeption('Custom token mismatch');
      default:
        return AppFirebaseAuthExeption(code);
    }
  }
}