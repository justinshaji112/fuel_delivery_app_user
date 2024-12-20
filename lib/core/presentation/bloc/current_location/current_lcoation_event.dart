part of 'current_lcoation_bloc.dart';

sealed class CurrentLcoationEvent extends Equatable {
  const CurrentLcoationEvent();

  @override
  List<Object> get props => [];
}
class GetLocationEvent extends CurrentLcoationEvent{}

class ChangeLocationEvent extends CurrentLcoationEvent{
  LatLng latLng;
  String address;
  ChangeLocationEvent({required this.latLng,required this.address});

  }