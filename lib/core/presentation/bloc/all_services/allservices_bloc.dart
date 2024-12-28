import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel_delivery_app_user/core/data/datasources/get_location_datasorce.dart';
import 'package:fuel_delivery_app_user/core/data/datasources/get_services_datasorce.dart';
import 'package:fuel_delivery_app_user/core/data/models/service_model.dart';
import 'package:geolocator/geolocator.dart';

part 'allservices_event.dart';
part 'allservices_state.dart';

class AllservicesBloc extends Bloc<AllservicesEvent, AllservicesState> {
  AllservicesBloc() : super(AllservicesInitial()) {
    on<GetServicesEvnt>((event, emit) async {
      emit(DataProsesingState());
      try {
        Future<Position> position=GetGeoLocation.getCurrentLocation() ;
        Map<String, List<ServiceModel>> services =
            await GetServices.getServices(possition: position);
        emit(ServiceGotState(services: services));
      } catch (e) {
        emit(DataErrorState(message: "Some Error Occured Check Your Internet connetion"));
      }
    });
  }
}
