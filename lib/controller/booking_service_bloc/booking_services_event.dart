// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_services_bloc.dart';

abstract class BookingEvent {}

class DateSelected extends BookingEvent {
  final DateTime date;
  DateSelected(this.date);
}

class TimeSelected extends BookingEvent {
  final TimeOfDay time;
  TimeSelected(this.time);
}

class PaymentMethodSelected extends BookingEvent {
  final String paymentMethod;
  PaymentMethodSelected(this.paymentMethod);
}

class SubmitOrderWithCashOnDeliveryEvent extends BookingEvent {
  String method;
  String serviceType;
  String serviceProviderId;

  String deliveryDate;
  String orderCompleteDate;
  String deliveryTime;
  String address;
  String longitude;
  String latitude;
  SubmitOrderWithCashOnDeliveryEvent({
    required this.method,
    required this.serviceType,
    required this.serviceProviderId,

    required this.deliveryDate,
    required this.orderCompleteDate,
    required this.deliveryTime,
    required this.address,
    required this.longitude,
    required this.latitude,
  });
}

class SubmitOrderWithOnlinePayment extends BookingEvent {
  String pymentId;
  String method;
  String serviceType;
  String serviceProviderId;
  String orderId;
  String deliveryDate;
  String orderCompleteDate;
  String deliveryTime;
  String address;
  String longitude;
  String latitude;
  SubmitOrderWithOnlinePayment({
    required this.method,
    required this.serviceType,
    required this.serviceProviderId,
    required this.orderId,
    required this.deliveryDate,
    required this.orderCompleteDate,
    required this.deliveryTime,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.pymentId,
  });
}
