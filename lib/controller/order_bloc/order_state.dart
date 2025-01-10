part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

class OrderLodedState extends OrderState {
  List<Map<String, dynamic>> orders = [];
}
