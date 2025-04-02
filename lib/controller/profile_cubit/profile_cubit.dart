import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel_delivery_app_user/models/address_model.dart';
import 'package:fuel_delivery_app_user/models/profile_model.dart';
import 'package:fuel_delivery_app_user/repository/profile_repo.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/add_address.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepo profileRepo;
  ProfileModel? profileModel;
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial()){
    getProfile();
  }
  
  getProfile()async{
    emit(ProfileLoading());
    try{
      ProfileModel? profile=await profileRepo.getProfileData();
      if(profile!=null){
        profileModel=profile;
        emit(ProfileSuccess(profile: profile));
      }
    }catch(e){
      emit(ProfileError(error: e.toString()));
    }
  }

  upDate({required ProfileModel profile})async{
    try{
     await profileRepo.updateProfile(profile);
      getProfile();

    }catch(e){
      emit(ProfileError(error: e.toString()));
    }
  }


  
}
