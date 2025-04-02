abstract interface class AuthRepo {
  Future<void> signUp(String email, String password, String phone, String name);
  Future<bool> signIn(String email, String password);

  Future<bool> signOut();
  Future<bool> resetPassword(String email);
  Future<bool> verifyEmail(String email);
  Future<bool> sendVerificationEmail();
  Future<bool> isUserLoggedIn();
  Future<bool> isEmailVerified();
  Future<bool> isPasswordResetEmailSent();
  Future<bool> signinWithGoogle();
}
