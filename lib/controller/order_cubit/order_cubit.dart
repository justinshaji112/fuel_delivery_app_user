import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel_delivery_app_user/models/order_model.dart';
import 'package:fuel_delivery_app_user/repository/order_repo.dart';
import 'package:fuel_delivery_app_user/repository/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderRepository orderRepository;
  OrderCubit({required this.orderRepository}) : super(OrderInitial()) {
    getOrders();
  }

  placeOrder(OrderModel order) async {
    emit(OrderLoading());
    try {
      await orderRepository.addOrder(order);
      emit(OrderSuccess());
      getOrders();
    } catch (e) {
      emit(OrderError(error: e.toString()));
    }
  }

  getOrders() async {
    emit(OrderLoading());
    try {
      List<OrderModel> orders = await orderRepository.getOrders();
      emit(OrdersFetchingSuccess(orders: orders));
    } catch (e) {
      emit(OrderError(error: e.toString()));
    }
  }

  updateOrder(OrderModel order) async {
    emit(OrderLoading());
    try {
      await orderRepository.updateOrder(order);
      emit(OrderSuccess());
      getOrders();
    } catch (e) {
      OrderError(error: e.toString());
    }
  }
}
