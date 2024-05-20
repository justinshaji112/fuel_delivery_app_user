import 'package:fuel_delivery_app_user/features/auth/domain/repositories/auth_rempsitory.dart';

abstract class CheckEmailVerifiedUsecase {
  Future<bool> exicute();
}

class CheckEmailVerifiedUsecaseImpl {
  AuthRepository authRepository;

  CheckEmailVerifiedUsecaseImpl({ required this.authRepository});
  @override
  Future<bool> exicute() async {
    return await authRepository.isEmailVaryfied();
  }
}
