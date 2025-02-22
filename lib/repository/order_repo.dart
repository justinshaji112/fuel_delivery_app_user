import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';

class OrderRepo{static Future<List<dynamic>> getUserOrders(String userId) async {
  try {
    var myOrders = [];

    var userDocument = await FireSetup.users.doc(userId).get();
   
    userDocument.data()?['Orders'].forEach((orderId) async {
      myOrders.add(orderId);
    });

    List<dynamic> orders = [];
    

    for (var orderId in myOrders) {
      ///kjkjkj 
      var orderDocument = await FireSetup.orders.doc(orderId).get();
      orders.add(orderDocument.data());
      orders.last['id'] = orderId;
    }




  
    return orders;
  } catch (e) {
    print('Error fetching orders: $e');
    return [];
  }
}}
