import 'package:fuel_delivery_app_user/core/presentation/pages/home/methods/payment_handile_methods.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OnlinePayment{

static  showRazorPaySheet(double price,String service){
                  Razorpay razorpay = Razorpay();
                  Map<String, Object> getTurboPaymentOptions () {
                    return {
                      "key": "rzp_test_KVEEmRUEiacNTK",
                      "amount": (price*100).toString(),
                      "name": "Fuell Delivery App",
                      "description": service,

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
                }
}