// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fuel_delivery_app_user/models/address_model.dart';
import 'package:fuel_delivery_app_user/models/service_model.dart';
import 'package:fuel_delivery_app_user/models/vehicle_model.dart';

//--------------------------------------------

//change service to Subservice               |
//--------------------------------------------
class OrderModel {
  String? orderId;
  String
      status; // "Pending", "Confirmed", "In Progress", "Delivered", "Cancelled"
  bool paymentDone;
  bool payOnDelivery;
  OrderCancelationDetails? orderCancelDetails;
  AddressModel address;
  VehicleModel vehicle;
  String createdAt;
  String updatedAt;
  String? deliveryAgentId;
  String serviceId;
  SubServiceModel service;
  String deliveryDate;
  String deliveryTime; // Instead of separate date & time
  String? customerId;
  double totalAmount;
  String? discountCode;
  double discountAmount;
  String paymentMethod; // "UPI", "Card", "Cash on Delivery"
  String? paymentId;

  String? notes;
  String? serviceProviderId;
  OrderModel({
    required this.orderId,
    required this.status,
    required this.paymentDone,
    required this.payOnDelivery,
    this.orderCancelDetails,
    required this.address,
    required this.vehicle,
    required this.createdAt,
    required this.updatedAt,
    this.deliveryAgentId,
    required this.serviceId,
    required this.service,
    required this.deliveryDate,
    required this.deliveryTime,
    this.customerId,
    required this.totalAmount,
    this.discountCode,
    required this.discountAmount,
    required this.paymentMethod,
    this.notes,
    this.serviceProviderId,
    required this.paymentId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'paymentId': paymentId,
      'status': status,
      'paymentDone': paymentDone,
      'payOnDelivery': payOnDelivery,
      'orderCancelDetails': orderCancelDetails?.toMap(),
      'address': address.toMap(),
      'vehicle': vehicle.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deliveryAgentId': deliveryAgentId,
      'serviceId': serviceId,
      'service': service.toMap(),
      'deliveryDate': deliveryDate,
      'deliveryTime': deliveryTime,
      'customerId': customerId,
      'totalAmount': totalAmount,
      'discountCode': discountCode,
      'discountAmount': discountAmount,
      'paymentMethod': paymentMethod,
      'notes': notes,
      'serviceProviderId': serviceProviderId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      paymentId: map['paymentId'] != null ? map['paymentId'] as String : null,
      orderId: map['id'] != null ? map['id'] as String : null,
      status: map['status'] as String,
      paymentDone: map['paymentDone'] as bool,
      payOnDelivery: map['payOnDelivery'] as bool,
      orderCancelDetails: map['orderCancelDetails'] != null
          ? OrderCancelationDetails.fromMap(
              map['orderCancelDetails'] as Map<String, dynamic>)
          : null,
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      vehicle: VehicleModel.fromMap(map['vehicle'] as Map<String, dynamic>),
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deliveryAgentId: map['deliveryAgentId'] != null
          ? map['deliveryAgentId'] as String
          : null,
      serviceId: map['serviceId'] as String,
      service: SubServiceModel.fromMap(map['service'] as Map<String, dynamic>),
      deliveryDate: map['deliveryDate'] as String,
      deliveryTime: map['deliveryTime'] as String,
      customerId:
          map['customerId'] != null ? map['customerId'] as String : null,
      totalAmount: map['totalAmount'] as double,
      discountCode:
          map['discountCode'] != null ? map['discountCode'] as String : null,
      discountAmount: map['discountAmount'] as double,
      paymentMethod: map['paymentMethod'] as String,
      notes: map['notes'] != null ? map['notes'] as String : null,
      serviceProviderId: map['serviceProviderId'] != null
          ? map['serviceProviderId'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  OrderModel copyWith({
    String? paymentId,
    String? orderId,
    String? status,
    bool? paymentDone,
    bool? payOnDelivery,
    OrderCancelationDetails? orderCancelDetails,
    AddressModel? address,
    VehicleModel? vehicle,
    String? createdAt,
    String? updatedAt,
    String? deliveryAgentId,
    String? serviceId,
    SubServiceModel? service,
    String? deliveryDate,
    String? deliveryTime,
    String? customerId,
    double? totalAmount,
    String? discountCode,
    double? discountAmount,
    String? paymentMethod,
    String? notes,
    String? serviceProviderId,
  }) {
    return OrderModel(
      paymentId: paymentId ?? this.paymentId,
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      paymentDone: paymentDone ?? this.paymentDone,
      payOnDelivery: payOnDelivery ?? this.payOnDelivery,
      orderCancelDetails: orderCancelDetails ?? this.orderCancelDetails,
      address: address ?? this.address,
      vehicle: vehicle ?? this.vehicle,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deliveryAgentId: deliveryAgentId ?? this.deliveryAgentId,
      serviceId: serviceId ?? this.serviceId,
      service: service ?? this.service,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      customerId: customerId ?? this.customerId,
      totalAmount: totalAmount ?? this.totalAmount,
      discountCode: discountCode ?? this.discountCode,
      discountAmount: discountAmount ?? this.discountAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
    );
  }

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId,paymentId: $paymentId, status: $status, paymentDone: $paymentDone, payOnDelivery: $payOnDelivery, orderCancelDetails: $orderCancelDetails, address: $address, vehicle: $vehicle, createdAt: $createdAt, updatedAt: $updatedAt, deliveryAgentId: $deliveryAgentId, serviceId: $serviceId, service: $service, deliveryDate: $deliveryDate, deliveryTime: $deliveryTime, customerId: $customerId, totalAmount: $totalAmount, discountCode: $discountCode, discountAmount: $discountAmount, paymentMethod: $paymentMethod, notes: $notes, serviceProviderId: $serviceProviderId)';
  }
}

class OrderCancelationDetails {
  bool cancelUser;
  bool cancelByAdmin;
  String? reasonForCancellation;
  OrderCancelationDetails({
    required this.cancelUser,
    required this.cancelByAdmin,
    this.reasonForCancellation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cancelUser': cancelUser,
      'cancelByAdmin': cancelByAdmin,
      'reasonForCancellation': reasonForCancellation,
    };
  }

  factory OrderCancelationDetails.fromMap(Map<String, dynamic> map) {
    return OrderCancelationDetails(
      cancelUser: map['cancelUser'] as bool,
      cancelByAdmin: map['cancelByAdmin'] as bool,
      reasonForCancellation: map['reasonForCancellation'] != null
          ? map['reasonForCancellation'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderCancelationDetails.fromJson(String source) =>
      OrderCancelationDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  OrderCancelationDetails copyWith({
    bool? cancelUser,
    bool? cancelByAdmin,
    String? reasonForCancellation,
  }) {
    return OrderCancelationDetails(
      cancelUser: cancelUser ?? this.cancelUser,
      cancelByAdmin: cancelByAdmin ?? this.cancelByAdmin,
      reasonForCancellation:
          reasonForCancellation ?? this.reasonForCancellation,
    );
  }

  @override
  String toString() =>
      'OrderCancelationDetails(cancelUser: $cancelUser, cancelByAdmin: $cancelByAdmin, reasonForCancellation: $reasonForCancellation)';
}
