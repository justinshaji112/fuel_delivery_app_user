part of 'carousel_cubit.dart';

sealed class CarouselState extends Equatable {
  const CarouselState();

  @override
  List<Object> get props => [];
}

final class CarouselInitial extends CarouselState {}

final class CarouselLoading extends CarouselState {}

final class CarouselSuccess extends CarouselState {
  List<CarouselModel>carousels;
  CarouselSuccess({required this.carousels});
}

final class CarouselError extends CarouselState {
  String error;
  CarouselError({required this.error});
}

