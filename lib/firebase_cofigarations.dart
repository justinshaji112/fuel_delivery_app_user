import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireSetup {
  static CollectionReference<Map<String, dynamic>> orders =
      FirebaseFirestore.instance.collection('orders');

    static CollectionReference<Map<String, dynamic>> userOrders =
      FirebaseFirestore.instance.collection('user-orders');
  static CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');
  static FirebaseAuth auth = FirebaseAuth.instance;

  static CollectionReference<Map<String, dynamic>> service =
      FirebaseFirestore.instance.collection('services');
  static DocumentReference<Map<String, dynamic>> profile =
      FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid);
    static CollectionReference<Map<String, dynamic>> carousels =
      FirebaseFirestore.instance.collection('carousels');


      
}
