// ignore_for_file: public_member_api_docs, sort_constructors_first
class TimeSlotModel {
  final String time; // e.g., "09:00-09:30"
  final int totalSlots;
  final int booked;
  final String id; // Firestore document ID

  TimeSlotModel({
    required this.time,
    required this.totalSlots,
    required this.booked,
    required this.id,
  });

  factory TimeSlotModel.fromMap(Map<String, dynamic> data, String id) {
    return TimeSlotModel(
      id: id,
      time: data['time'] ?? '',
      totalSlots: data['totalSlots'] ?? 0,
      booked: data['booked'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "time": time,
      "totalSlots": totalSlots,
      "booked": booked,
    };
  }

  bool get isAvailable => booked < totalSlots;
}

