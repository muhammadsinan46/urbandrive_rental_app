import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPayment {
  Razorpay razorPay = Razorpay();
  final razorKey = " 'rzp_test_M3Qr6Ay0H4LabB'";

  paymentDetails(String totalpay, String modeldetails, bookingId) {
    print("razorpay loading....");
    var options = {
      'key': razorKey,
      'amount': int.parse(totalpay),
      'name': 'Urban Drive',
      "order_id": bookingId,
      'description': modeldetails,
      'prefill': {'contact': '987654321', 'email': 'admin@urbandrive.com'}
    };

    print("razor details are ${options}");

    try {
      razorPay.open(options);
    } catch (e) {
      print("error is ${e.toString()}");
    }
  }

  initiateRazorpay() {
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  }

  _handlePaymentError(PaymentFailureResponse response) {
    print("response of failure is $response");
    Fluttertoast.showToast(
      
        msg: "ERROR HERE:${response.code}- ${response.message}",
        timeInSecForIosWeb: 4);

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment failed")));
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT : ${response.paymentId}", timeInSecForIosWeb: 4);
  }
}
