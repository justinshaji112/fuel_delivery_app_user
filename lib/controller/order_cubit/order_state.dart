part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}
final class OrderLoading extends OrderState {}
final class OrderSuccess extends OrderState {}
final class OrderError extends OrderState {
  String error;
  OrderError({required this.error});
}

final class OrdersFetchingSuccess extends OrderState{
  List<OrderModel> orders;
  OrdersFetchingSuccess({required this.orders});
}
