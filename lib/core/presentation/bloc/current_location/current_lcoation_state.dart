part of 'current_lcoation_bloc.dart';

sealed class CurrentLcoationState extends Equatable {
  const CurrentLcoationState();

  @override
  List<Object> get props => [];
}

final class CurrentLcoationInitial extends CurrentLcoationState {}

final class LocationGotState extends CurrentLcoationState {
  LocationGotState({
    required this.cityName,
    required this.address,
    required this.lat,
    required this.log,
  });

  String cityName;
  String address;
  double lat;
  double log;
}

final class LocationErrorState extends CurrentLcoationState {
  String message = "Cant find the Locaion. please Check Location Enabled or Not";
}
