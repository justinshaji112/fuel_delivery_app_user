import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_delivery_app_user/config/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/core/data/models/service_model.dart';
import 'package:geolocator/geolocator.dart';

class GetServices {
  static Future<Map<String, List<ServiceModel>>> getServices(
     {required Future<Position> possition}) async {
    Map<String, List<ServiceModel>> services = {};
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FireSetup.service.get();

    for (var element in snapshot.docs) {
      List<dynamic> serviceList = element["services"];

      for (var service in serviceList) {
        int n = service["maximamDeliverableDistence"];
        double md = n.toDouble();
        ServiceModel serviceModel = ServiceModel(
          discription: service["discription"] as String,
          imageUrl: (service["imageUrl"] as List<dynamic>).cast<String>(),
          nameOfService: service["nameOfService"] as String,
          typeOfService: service["typeOfService"] as String,
          licenceDocument: service["licenceDocument"] as String,
          maximamDeliverableDistence: md,
          discountPrice: service['discountPrice'].toDouble(),
          finalPrice: service['finalPrice'].toDouble(),
          price: service['price'].toDouble(),
          isAccepted: service['isAccepted'],
          ProviderId: element.id,
          latitude: service["latitude"] as double,
          longitude: service["longitude"] as double,
        );
        Position ps = await possition;

        double dist = distance(ps.latitude, ps.longitude, serviceModel.latitude,
            serviceModel.longitude);
        print(dist);
        if (dist <= serviceModel.maximamDeliverableDistence) {
          if (!services.containsKey(serviceModel.typeOfService)) {
            services[serviceModel.typeOfService] = [];
           
          }
            services[serviceModel.typeOfService]!.add(serviceModel);
        }

       
      }
    }

    print("avilable services are :${services}");
    return services;
  }
}

double distance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371;
  final dLat = _degreesToRadians(lat2 - lat1);
  final dLon = _degreesToRadians(lon2 - lon1);
  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreesToRadians(lat1)) *
          cos(_degreesToRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}
