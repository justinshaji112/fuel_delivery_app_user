// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fuel_delivery_app_user/models/address_model.dart';
import 'package:fuel_delivery_app_user/models/vehicle_model.dart';

class ProfileModel {
  String name;
  String? phone;
  String? email;
  int? selectedAddress;
  int? selectedVehicle;
  List<AddressModel>address;
  List<VehicleModel> vehicles;
  ProfileModel(
      {required this.email,
      required this.name,
      required this.phone,
      required this.address,
      required this.vehicles,
      required this.selectedAddress,
      required this.selectedVehicle});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'address': address?.map((x) => x.toMap()).toList(),
      'vehicles': vehicles?.map((x) => x.toMap()).toList(),
      'selectedAddress': selectedAddress,
      'selectedVehicle': selectedVehicle,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic>? map) {
    return ProfileModel(
      selectedVehicle: map?["selectedVehicle"] != null
          ? int.parse(map!["selectedVehicle"].toString())
          : null,
      selectedAddress: map?["selectedAddress"] != null
          ? int.parse(map!["selectedAddress"].toString())
          : null,
      name: map?['name'] as String,
      phone: map?['phone'] != null ? map!['phone'] as String : null,
      email: map?['email'] != null ? map!['email'] as String : null,
      address: map?['address'] != null
          ? List<AddressModel>.from(
              (map?['address'] as List<dynamic>).map<AddressModel?>(
                (x) => AddressModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      vehicles: map?['vehicles'] != null
          ? List<VehicleModel>.from(
              (map?['vehicles'] as List<dynamic>).map<VehicleModel?>(
                (x) => VehicleModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProfileModel copyWith({
    String? name,
    String? phone,
    String? email,
    int? selectedAddress,
    List<AddressModel>? address,
    List<VehicleModel>? vehicles,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedVehicle: selectedAddress ?? this.selectedAddress,
      address: address ?? this.address,
      vehicles: vehicles ?? this.vehicles,
    );
  }
}
