import 'package:flutter/material.dart';

import '../payment/payment_input_field.dart';
import '../payment/payment_validators.dart';
import '../screens/paypal_header.dart';
import '../utils/app_colors.dart';
import '../Component/app_button.dart';

class PaypalPaymentPage extends StatefulWidget {
  final VoidCallback onSuccess;

  const PaypalPaymentPage({
    super.key,
    required this.onSuccess,
  });

  @override
  State<PaypalPaymentPage> createState() =>
      _PaypalPaymentPageState();
}

class _PaypalPaymentPageState
    extends State<PaypalPaymentPage> {
  final email = TextEditingController();

  String error = "";

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  bool validateEmail() {
    final result = PaypalEmailValidator().validate(email.text);

    if (result != null) {
      setState(() => error = result);
      return false;
    }

    setState(() => error = "");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        
        iconTheme: const IconThemeData(
          color: AppColors.paypalBlue,
        ),

        
        title: const Text(
          "PAYPAL PAYMENT",
          style: TextStyle(
            color: AppColors.paypalBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            const PaypalHeader(),

            const SizedBox(height: 30),

            if (error.isNotEmpty)
              Text(error, style: const TextStyle(color: Colors.red)),

            PaymentInputField(
              controller: email,
              hint: "PayPal Email",
              maxLength: 50,
              onChanged: () {},
            ),

            const Spacer(),

            /// 🔵 PayPal BUTTON (instead of gold)
            AppButton(
              text: "CONTINUE",
              backgroundColor: AppColors.paypalBlue,
              onPressed: () {
                if (!validateEmail()) return;

                widget.onSuccess();
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }
}