import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/domain/repositories/auth_rempsitory.dart';


abstract class CheckSignInnUsecase {
  @override
  Future<User?> exicute();
}

class CheckSignInUsecaseImpl extends CheckSignInnUsecase {
  AuthRepository authRepository;
  CheckSignInUsecaseImpl({required this.authRepository});

  @override
  @override
  Future<User?> exicute() {
    return authRepository.isLogedIn();
  }
}
