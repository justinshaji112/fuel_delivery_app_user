// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fuel_delivery_app_user/utils/constants/images.dart';

class ServiceCard {
  String imageUrl;
  String key;
  String serviceType;
  ServiceCard({
    required this.imageUrl,
    required this.key,
    required this.serviceType,
  });
}

class ServiceCards {
 static List<ServiceCard> cards = [
    ServiceCard(
        imageUrl: ImageUrls.fuelDeliveryImg_1,
        key: "Fuel Delivery",
        serviceType: "Fuel delivery"),
    ServiceCard(
      imageUrl: ImageUrls.evCharging_1,
        key: "EV Charge",
        serviceType: "Ev Charging"),
    ServiceCard(
        imageUrl: ImageUrls.carWashingImage,
        key: "Car Wash",
        serviceType: "Car wash"),
    ServiceCard(
        imageUrl: ImageUrls.oilChangeImg_1,
        key: "Oil Change",
        serviceType: "Oil Change"),
    ServiceCard(
        imageUrl: ImageUrls.deepCleanImg_1,
        key: "Deep Clean",
        serviceType: "Deep  clean"),
    ServiceCard(
        imageUrl: ImageUrls.otherService_1,
        key: "Other",
        serviceType: "Other services"),
  ];
}
