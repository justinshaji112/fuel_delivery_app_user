// import 'package:flutter/material.dart';
// import 'package:fuel_delivery_app_user/core/presentation/pages/home/methods/payment_handile_methods.dart';
// import 'package:fuel_delivery_app_user/core/presentation/pages/home/widgets/fuel_selection_sheet.dart';
// import 'package:fuel_delivery_app_user/core/presentation/pages/home/widgets/order_summery_sheet.dart';

// void _showFuelSelectionSheet(BuildContext context,{required String selectedFuelType, required int quantity}) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => StatefulBuilder(
//         builder: (BuildContext context, StateSetter setModalState) {
//           return FuelSelectionSheet(
//             selectedFuelType: selectedFuelType,
//             quantity: quantity,
//             onFuelTypeChanged: (newType) {
//               setModalState(() => selectedFuelType = newType);
//               setState(() => selectedFuelType = newType);
//             },
//             onQuantityChanged: (newQuantity) {
//               setModalState(() => quantity = newQuantity);
//               setState(() => quantity = newQuantity);
//             },
//             onProceed: () {
//               Navigator.pop(context);
//               _showOrderSummarySheet(context);
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _showOrderSummarySheet(BuildContext context, {required String selectedFuelType, required int quantity, required double pricePerLiter, required String selectedPaymentMethod}) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => StatefulBuilder(
//         builder: (BuildContext context, StateSetter setModalState) {
//           return OrderSummarySheet(
//             selectedFuelType: selectedFuelType,
//             quantity: quantity,
//             pricePerLiter: pricePerLiter,
//             selectedPaymentMethod: selectedPaymentMethod,
//             onPaymentMethodChanged: (newMethod) {
//               setModalState(() => selectedPaymentMethod = newMethod);
//               setState(() => selectedPaymentMethod = newMethod);
//             },
//             onPlaceOrder: () {
//               Navigator.pop(context);
//              HandilePayment. showOrderConfirmation(context);
//             },
//           );
//         },
//       ),
//     );
//   }
  