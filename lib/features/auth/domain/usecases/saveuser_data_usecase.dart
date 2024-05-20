import 'package:dartz/dartz.dart';
import 'package:fuel_delivery_app_user/core/errors/faliure.dart';
import 'package:fuel_delivery_app_user/features/auth/data/models/auth_model.dart';
import 'package:fuel_delivery_app_user/features/auth/domain/repositories/auth_rempsitory.dart';

abstract class SaveUserDataUseCase {
  Future<Either<Failure, bool>> exicute(
      {required UserModel user, required String uid});
}

class SaveUserDataUsecaseImpl extends SaveUserDataUseCase {
  AuthRepository userRepository;
  SaveUserDataUsecaseImpl({required this.userRepository});

  @override
  Future<Either<Failure, bool>> exicute(
      {required UserModel user, required String uid}) {
   return userRepository.saveUserData(
        uid: uid,
        email: user.email,
        phoneNumber: user.phoneNumber,
        displayName: user.name);
  }
}
