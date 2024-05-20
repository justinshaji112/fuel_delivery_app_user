import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireSetup {
  static CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');
  static FirebaseAuth auth = FirebaseAuth.instance;
}
