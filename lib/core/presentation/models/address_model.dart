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
      country: map['country'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      city: map['city'] ?? '',
      streetAddress: map['streetAddress'] ?? '',
      addressType: map['addressType'] ?? '',
      postalCode: map['postalCode'] ?? '',
      apartmentUnit: map['apartmentUnit'] ?? '',
      fullName: map['fullName'] ?? '',
      state: map['state'] ?? '',
    );
  }
}