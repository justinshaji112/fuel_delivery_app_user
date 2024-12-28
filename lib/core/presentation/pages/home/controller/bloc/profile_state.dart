part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileErrorState extends ProfileState {
  String error;
  ProfileErrorState({required this.error});
}

final class ProfileLodedState extends ProfileState {
  final List<AddressModel> address;
  final List<VehicleModel> vehicles;
  final Map<String, dynamic> profileData;

  const ProfileLodedState({
    required this.address,
    required this.vehicles,
    required this.profileData,
  });

  @override
  List<Object> get props => [address, vehicles, profileData];
}


class ProfileLoadingState extends ProfileState{}