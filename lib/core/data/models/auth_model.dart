import 'package:equatable/equatable.dart';
import 'package:fuel_delivery_app_user/core/domain/entities/user_entitiy.dart';

class UserModel extends UserEntity with EquatableMixin {
        

  // ignore: use_super_parameters
  UserModel(
      {
        String? uid,
        required String email,
      required String password,
      required String phoneNumber,
      required String name}):super(email: email, name: name, password: password, phoneNumber: phoneNumber,uid: uid);
      


  @override
  List<Object?> get props => [email, password, phoneNumber, name,uid];



}
