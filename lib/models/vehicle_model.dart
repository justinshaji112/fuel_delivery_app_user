// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VehicleModel {
  final String make;
  final String model;
  final String year;
  final String type;
  final bool isElectric;
  final String? batteryCapacity;
  final String? chargerType;

  VehicleModel({
    required this.make,
    required this.model,
    required this.year,
    required this.type,
    required this.isElectric,
    this.batteryCapacity,
    this.chargerType,
  });

  Map<String, dynamic> toJson() => {
        "make": make,
        "model": model,
        "year": year,
        "type": type,
        "isElectric": isElectric,
        "batteryCapacity": batteryCapacity,
        "chargerType": chargerType
      };

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      make: map['make'] as String,
      model: map['model'] as String,
      year: map['year'] as String,
      type: map['type'] as String,
      isElectric: map['isElectric'] as bool,
      batteryCapacity: map['batteryCapacity'] != null ? map['batteryCapacity'] as String : null,
      chargerType: map['chargerType'] != null ? map['chargerType'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'make': make,
      'model': model,
      'year': year,
      'type': type,
      'isElectric': isElectric,
      'batteryCapacity': batteryCapacity,
      'chargerType': chargerType,
    };
  }

  // String toJson() => json.encode(toMap());

  factory VehicleModel.fromJson(String source) => VehicleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
