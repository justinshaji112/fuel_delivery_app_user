import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel_delivery_app_user/services/profile_date_service.dart';
import 'package:fuel_delivery_app_user/models/address_model.dart';
import 'package:fuel_delivery_app_user/models/vehicle_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileDateService _profileService = ProfileDateService();

  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileData>((event, emit) async {
      emit(ProfileLoadingState());
      
      try {
        await Future.wait([
          emit.forEach(
            _profileService.getProfileData(),
            onData: (Map<String, dynamic> profileData) {
              return ProfileLodedState(
                address: state is ProfileLodedState ? (state as ProfileLodedState).address : [],
                vehicles: state is ProfileLodedState ? (state as ProfileLodedState).vehicles : [],
                profileData: profileData,
              );
            },
          ),
          emit.forEach(
            _profileService.getAddressStream(),
            onData: (List<AddressModel> addresses) {
              return ProfileLodedState(
                address: addresses,
                vehicles: state is ProfileLodedState ? (state as ProfileLodedState).vehicles : [],
                profileData: state is ProfileLodedState ? (state as ProfileLodedState).profileData : {},
              );
            },
          ),
          emit.forEach(
            _profileService.getVehiclesStream(),
            onData: (List<VehicleModel> vehicles) {
              return ProfileLodedState(
                address: state is ProfileLodedState ? (state as ProfileLodedState).address : [],
                vehicles: vehicles,
                profileData: state is ProfileLodedState ? (state as ProfileLodedState).profileData : {},
              );
            },
          ),
        ]);
      } catch (e) {
        emit(ProfileErrorState(error: e.toString()));
      }
    });
  }
}