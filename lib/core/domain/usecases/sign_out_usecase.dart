import 'package:fuel_delivery_app_user/core/domain/repositories/auth_rempsitory.dart';


abstract class SingOutUsecase{
    Future<void> exicute();


}

class SingOutUsecaseImpl extends SingOutUsecase{
  AuthRepository authRepository;
  SingOutUsecaseImpl({required this.authRepository});

    @override
  Future<void> exicute() {
    return authRepository.logOut();
  }

  
}
