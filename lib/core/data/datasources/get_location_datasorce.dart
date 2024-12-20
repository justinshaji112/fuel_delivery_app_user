import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetGeoLocation {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final a = await Geolocator.getCurrentPosition();
    print("logiturde is ${a.longitude}");
    print("logiturde is ${a.latitude}");
    return a;
  }

  static Future<Map<String, dynamic>> getCurrentAddress(
      {LatLng? latlog}) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks;

      if (latlog == null) {
         placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
      }else{

            placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
      }

      Placemark place = placemarks[0];

      String address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      print("address is: $address");

      return {
        "address": address,
        "city": place.locality,
        "lat": position.latitude,
        "lon": position.longitude
      };
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}
