// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel_delivery_app_user/controller/auth_cubit/auth_cubit.dart';
import 'package:fuel_delivery_app_user/models/service_model.dart';
import 'package:fuel_delivery_app_user/repository/service_repo.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  final ServicesRepo servicesRepo;
  
  ServiceCubit({required this.servicesRepo}) : super(ServiceInitial());

  Future<void> getServices() async {
    emit(ServiceLoading());
    try {
      log("Fetching services...");
      List<ServiceModel> services = await servicesRepo.getServices();
      log("Services fetched: ${services.length}");
      emit(ServiceSuccess(services: services));
    } catch (e) {
      log("Error fetching services: ${e.toString()}");
      emit(ServiceError(error: e.toString()));
    }
  }

  @override
  void onChange(Change<ServiceState> change) {
    super.onChange(change);
    log("ServiceCubit change: ${change.toString()}");
  }
}
