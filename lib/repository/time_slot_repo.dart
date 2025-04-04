import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_delivery_app_user/models/slot_model.dart';

class TimeSlotRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<TimeSlotModel>> getAvailableSlots({
    required String serviceId,
    required DateTime date,
  }) async {
    String dateKey = "${date.year}-${date.month}-${date.day}";

    QuerySnapshot snapshot = await firestore
        .collection('slots')
        .doc(serviceId.trim())
        .collection('dates')
        .doc(dateKey)
        .collection('slots')
        .orderBy("time")
        .get();

    List<TimeSlotModel> slots = snapshot.docs.map((doc) {
      return TimeSlotModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    return slots;
  }

  String formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
