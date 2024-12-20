import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel_delivery_app_user/core/data/datasources/get_location_datasorce.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'current_lcoation_event.dart';
part 'current_lcoation_state.dart';

class CurrentLcoationBloc
    extends Bloc<CurrentLcoationEvent, CurrentLcoationState> {
  CurrentLcoationBloc() : super(CurrentLcoationInitial()) {
    on<GetLocationEvent>(
      (event, emit) async {
        try {
          Map<String, dynamic> location =
              await GetGeoLocation.getCurrentAddress();
          emit(LocationGotState(
              cityName: location["city"],
              address: location["address"],
              lat: location["lat"] as double,
              log: location["lon"] as double));
        } catch (e) {
          print("error is :  $e");
          emit(LocationErrorState());
        }
      },
    );

    on<ChangeLocationEvent>(
      (event, emit) {
        emit(LocationGotState(
            cityName: event.address,
            address: event.address,
            lat: event.latLng.latitude,
            log: event.latLng.longitude));
      },
    );
  }
}
