// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServiceModel {
  List<String> imageUrl;
  String nameOfService;
  String typeOfService;
  String licenceDocument;
  double maximamDeliverableDistence;
  double discountPrice;
  double finalPrice;
  double price;
  bool? isAccepted;
  String ProviderId;
  double latitude;
  double longitude;
  String discription;
  ServiceModel({
    required this.imageUrl,
    required this.nameOfService,
    required this.typeOfService,
    required this.licenceDocument,
    required this.maximamDeliverableDistence,
    required this.discountPrice,
    required this.finalPrice,
    required this.price,
    this.isAccepted,
    required this.ProviderId,
    required this.latitude,
    required this.longitude,
    required this.discription,
  });
  

 

  @override
  String toString() {
    return 'ServiceModel(imageUrl: $imageUrl, nameOfService: $nameOfService, typeOfService: $typeOfService, licenceDocument: $licenceDocument, maximamDeliverableDistence: $maximamDeliverableDistence, discountPrice: $discountPrice, finalPrice: $finalPrice, price: $price, isAccepted: $isAccepted, ProviderId: $ProviderId, latitude: $latitude, longitude: $longitude, discription: $discription)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'nameOfService': nameOfService,
      'typeOfService': typeOfService,
      'licenceDocument': licenceDocument,
      'maximamDeliverableDistence': maximamDeliverableDistence,
      'discountPrice': discountPrice,
      'finalPrice': finalPrice,
      'price': price,
      'isAccepted': isAccepted,
      'ProviderId': ProviderId,
      'latitude': latitude,
      'longitude': longitude,
      'discription': discription,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      imageUrl: List<String>.from((map['imageUrl'] as List<String>)),
      nameOfService: map['nameOfService'] as String,
      typeOfService: map['typeOfService'] as String,
      licenceDocument: map['licenceDocument'] as String,
      maximamDeliverableDistence: map['maximamDeliverableDistence'] as double,
      discountPrice: map['discountPrice'] as double,
      finalPrice: map['finalPrice'] as double,
      price: map['price'] as double,
      isAccepted: map['isAccepted'] != null ? map['isAccepted'] as bool : null,
      ProviderId: map['ProviderId'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      discription: map['discription'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) => ServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
