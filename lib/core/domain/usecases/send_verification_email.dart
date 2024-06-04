

import '../../auth/domain/repositories/auth_rempsitory.dart';

abstract class SendVerificationEmaileUsecase {
  @override
  Future<void> exicute();
}

class SendVerificationEmaileUsecaseImpl extends SendVerificationEmaileUsecase {
  AuthRepository authRepository;
  SendVerificationEmaileUsecaseImpl({required this.authRepository});

  @override
  Future<void> exicute() async {
    return await authRepository.sendEmailVarification();
  }
}
