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

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      make: map['make'] ?? '',
      model: map['model'] ?? '',
      year: map['year'] ?? "",
      type: map['type'] ?? '',
      isElectric: map['isElectric'] ?? false,
      batteryCapacity:map['batteryCapacity']??"",
      chargerType: map['chargerType'],
    );
  }
}