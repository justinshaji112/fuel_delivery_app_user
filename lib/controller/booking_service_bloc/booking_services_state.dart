part of 'booking_services_bloc.dart';

class BookingState {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String paymentMethod;

  BookingState({
    required this.paymentMethod,
    required this.selectedDate,
    required this.selectedTime,
  });

  BookingState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? paymentMethod,
  }) {
    return BookingState(
      paymentMethod: paymentMethod?? this.paymentMethod,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }
}


class OrderCompletedState extends BookingState{
  OrderCompletedState({required super.paymentMethod, required super.selectedDate, required super.selectedTime});

}


