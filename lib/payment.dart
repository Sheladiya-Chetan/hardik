import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class payment extends StatefulWidget {
  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  Razorpay? razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = Razorpay();
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(onTap: () {
        var options = {
          'key': 'rzp_test_rMwFGAaC42c7I2',
          'amount': 10000,
          'name': 'Acme Corp.',
          'description': 'Fine T-Shirt',
          'prefill': {
            'contact': '8866613350',
            'email': 'test@razorpay.com'
          }
        };
        razorpay!.open(options);
      },child: Align(alignment: Alignment.center,
        child: Container(
          height: 60,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            color: Colors.white10,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.purple,
                offset: Offset(3.0, 3.0), //(x,y)
                blurRadius: 5.0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            "Paymnet",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      )),
    );
  }
}
