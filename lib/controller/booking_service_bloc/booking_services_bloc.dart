import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';

part 'booking_services_event.dart';
part 'booking_services_state.dart';

// State

// BLoC
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc()
      : super(BookingState(
            selectedDate: DateTime.now(),
            selectedTime: TimeOfDay(hour: 15, minute: 0),
            paymentMethod: 'cash')) {
    on<DateSelected>((event, emit) {
      emit(state.copyWith(selectedDate: event.date));
    });
    on<TimeSelected>((event, emit) {
      emit(state.copyWith(selectedTime: event.time));
    });

    on<PaymentMethodSelected>(
      (event, emit) => emit(state.copyWith(paymentMethod: event.paymentMethod)),
    );

    on<SubmitOrderWithCashOnDeliveryEvent>(
      (event, emit) async {
        try {

        
          final a = await FireSetup.orders.add({
            "orderStatus":"processing",
            "userId":FireSetup.auth.currentUser!.uid,
             "pymentStatus":"pending",
            "paymentMethod": event.method,
            "service": event.serviceType,
            "serviceProviderId": event.serviceProviderId,
            "deliveryDate": event.deliveryDate,
            "deliveryTime": event.deliveryTime,
            "deliveryAddress": event.address,
            "orderDate": event.orderCompleteDate
          });
          emit(OrderCompletedState(paymentMethod: event.method, selectedDate: DateTime.parse(event.deliveryDate.split(" ")[0]), selectedTime: TimeOfDay.now()));
          print(a.toString());
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
