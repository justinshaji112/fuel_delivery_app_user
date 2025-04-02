import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/models/profile_model.dart';
import 'package:fuel_delivery_app_user/utils/exceptions/app_exeption_handler.dart';

class ProfileRepo {
 Future<ProfileModel?> getProfileData()async{
try{   final profileDataSnapshot=await FireSetup.profile.get();
   ProfileModel? profileModel=ProfileModel.fromMap(profileDataSnapshot.data());
   return profileModel;
}catch(e){
  throw Exception(AppExceptionHandler.  handleException(e));
}
 }


 updateProfile(ProfileModel profile)async{
  try{
    FireSetup.profile.update(profile.toMap());

  }catch(e){
    throw Exception(AppExceptionHandler.handleException(e));
  }



 }
}
