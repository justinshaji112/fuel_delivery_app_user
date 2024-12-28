import 'package:fuel_delivery_app_user/config/firebase_cofigarations.dart';

class GetOrders{

  static Future<List<Map<String,dynamic>>>getOrders()async{
   final a=await FireSetup.orders.doc().get();
final userId = FireSetup.auth.currentUser!.uid;
var orders=await FireSetup.
    orders
    .where('userId', isEqualTo: userId)
    .get()
    .then((querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList()); 
    print("my orders are: $orders");
    return orders;
     }
   
}