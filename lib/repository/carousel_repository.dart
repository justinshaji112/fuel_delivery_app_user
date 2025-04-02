import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/models/carousel_model.dart';
import 'package:fuel_delivery_app_user/utils/exceptions/app_exeption_handler.dart';

class CarouselRepository {
  getCarousels() async {
    // static CollectionReference<Map<String, dynamic>> carousels =
    //   FirebaseFirestore.instance.collection('carousels');
    try {
      QuerySnapshot querySnapshot = await FireSetup.carousels.get();
      log(querySnapshot.toString());
      return querySnapshot.docs
          .map((e) => CarouselModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(AppExceptionHandler.handleException(e));
    }
  }

    

  

  
}
