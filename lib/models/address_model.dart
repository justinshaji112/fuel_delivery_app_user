// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddressModel {
  final String country;
  final String phoneNumber;
  final String city;
  final String streetAddress;
  final String addressType;
  final String postalCode;
  final String apartmentUnit;
  final String fullName;
  final String state;

  AddressModel({
    required this.country,
    required this.phoneNumber,
    required this.city,
    required this.streetAddress,
    required this.addressType,
    required this.postalCode,
    required this.apartmentUnit,
    required this.fullName,
    required this.state,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      country: map['country'] as String,
      phoneNumber: map['phoneNumber'] as String,
      city: map['city'] as String,
      streetAddress: map['streetAddress'] as String,
      addressType: map['addressType'] as String,
      postalCode: map['postalCode'] as String,
      apartmentUnit: map['apartmentUnit'] as String,
      fullName: map['fullName'] as String,
      state: map['state'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'phoneNumber': phoneNumber,
      'city': city,
      'streetAddress': streetAddress,
      'addressType': addressType,
      'postalCode': postalCode,
      'apartmentUnit': apartmentUnit,
      'fullName': fullName,
      'state': state,
    };
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

