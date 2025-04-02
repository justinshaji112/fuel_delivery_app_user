import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/models/order_model.dart';
import 'package:fuel_delivery_app_user/utils/exceptions/app_exeption_handler.dart';

class OrderRepository {
  Future<List<OrderModel>> getOrders() async {
    try {
      final orderIds = await getOrderIds();
      if (orderIds.isEmpty) return [];

      QuerySnapshot<Map<String, dynamic>> snapshot = await FireSetup.orders
          .where(FieldPath.documentId, whereIn: orderIds)
          .get();

      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception(AppExceptionHandler.handleException(e));
    }
  }

  Future<List<String>> getOrderIds() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FireSetup.userOrders.doc(FireSetup.auth.currentUser!.uid).get();
      final List<dynamic>? a = documentSnapshot.data()?["orders"];

      // Ensure it's not null and map each item to String
      List<String> orderIds = a?.map((e) => e.toString()).toList() ?? [];

      return orderIds;
    } catch (e) {
      throw Exception(AppExceptionHandler.handleException(e));
    }
  }

  Future<void> addOrder(OrderModel order) async {
    try {
      DocumentReference userOrdersRef =
          FireSetup.userOrders.doc(FireSetup.auth.currentUser!.uid);

      DocumentReference orderRef = await FireSetup.orders.add(order.toMap());
      String newOrderId = orderRef.id;

      await userOrdersRef.set({
        "orders": FieldValue.arrayUnion([newOrderId])
      }, SetOptions(merge: true));

      await orderRef.update({"id": orderRef.id});
    } catch (e) {
      throw Exception(AppExceptionHandler.handleException(e));
    }
  }

  Future<void> updateOrder(OrderModel order) async {
    try {
      await FireSetup.orders.doc(order.orderId).update(order.toMap());
    } catch (e) {
      throw Exception(AppExceptionHandler.handleException(e));
    }
  }
}
