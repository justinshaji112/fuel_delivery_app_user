import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/methods/payment_handile_methods.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/widgets/payment_method_selector.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderSummarySheet extends StatelessWidget {
  final String selectedFuelType;
  final int quantity;
  final double pricePerLiter;
  final String selectedPaymentMethod;
  final Function(String) onPaymentMethodChanged;
  final VoidCallback onPlaceOrder;

  OrderSummarySheet({
    required this.selectedFuelType,
    required this.quantity,
    required this.pricePerLiter,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10),
            ],
          ),
          child: ListView(
            controller: controller,
            padding: EdgeInsets.all(20),
            children: [
              Text(
                'Order Summary',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildSummaryRow('Fuel Type', selectedFuelType),
              _buildSummaryRow('Quantity', '$quantity L'),
              _buildSummaryRow(
                  'Price', '₹${(quantity * pricePerLiter).toStringAsFixed(2)}'),
              SizedBox(height: 30),
              Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              PaymentMethodSelector(
                selectedMethod: selectedPaymentMethod,
                onChanged: onPaymentMethodChanged,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Razorpay razorpay = Razorpay();
                  Map<String, Object> getTurboPaymentOptions() {
                    return {
                      "key": "rzp_test_KVEEmRUEiacNTK",
                      "amount": (pricePerLiter*quantity*100).toString(),
                      "name": "Fuell Delivery App",
                      "description": selectedFuelType,

                      "external": {
                        "wallets": ["paytm"]
                      }
                    };
                  }

                  //Handle Payment Responses
                 

                  razorpay.on(
                      Razorpay.EVENT_PAYMENT_ERROR, HandilePayment.handlePaymentErrorResponse);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    HandilePayment.  handlePaymentSuccessResponse);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                    HandilePayment.  handleExternalWalletSelected);
                  razorpay.open(getTurboPaymentOptions());
                },
                child: Text('Place Order'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}