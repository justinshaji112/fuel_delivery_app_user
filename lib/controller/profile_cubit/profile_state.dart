part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}
final class ProfileSuccess extends ProfileState {
  ProfileModel profile;
  ProfileSuccess({required this.profile});
}
final class ProfileLoading extends ProfileState {}

final class ProfileError extends ProfileState {
  String error;
  ProfileError({required this.error});
}








