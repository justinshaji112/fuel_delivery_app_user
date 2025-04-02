import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel_delivery_app_user/models/carousel_model.dart';
import 'package:fuel_delivery_app_user/models/profile_model.dart';
import 'package:fuel_delivery_app_user/repository/carousel_repository.dart';
import 'package:fuel_delivery_app_user/repository/profile_repo.dart';

part 'carousel_state.dart';

class CarouselCubit extends Cubit<CarouselState> {
  CarouselRepository carouselRepository;
  CarouselCubit({required this.carouselRepository}) : super(CarouselInitial()) {
    getCarousels();
  }

  getCarousels() async {

    try {
      emit(CarouselLoading());
      List<CarouselModel> carousels = await carouselRepository.getCarousels();
      emit(CarouselSuccess(carousels: carousels));
    } catch (e) {
      emit(CarouselError(error: e.toString()));
    }
  }
}
