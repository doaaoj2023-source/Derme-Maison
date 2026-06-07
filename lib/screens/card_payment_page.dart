import 'package:flutter/material.dart';

import '../payment/payment_input_field.dart';
import '../payment/payment_validators.dart';
import '../payment/glow_circle.dart';
import '../payment/payment_card.dart';
import '../checkout/app_snackbar.dart';
import '../profile/widgets/profile_background.dart';

import '../utils/app_colors.dart';
import '../Component/app_button.dart';

class CardPaymentPage extends StatefulWidget {
  final VoidCallback onSuccess;

  const CardPaymentPage({super.key, required this.onSuccess});

  @override
  State<CardPaymentPage> createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  final number = TextEditingController();
  final name = TextEditingController();
  final exp = TextEditingController();
  final cvv = TextEditingController();

  String error = "";

  bool validateFields() {
    final validators = [
      CardNumberValidator(),
      CardHolderValidator(),
      ExpiryValidator(),
      CvvValidator(),
    ];

    final values = [
      number.text,
      name.text,
      exp.text,
      cvv.text,
    ];

    for (int i = 0; i < validators.length; i++) {
      final result = validators[i].validate(values[i]);
      if (result != null) {
        setState(() => error = result);
        return false;
      }
    }

    setState(() => error = "");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      ///  UNIFIED APP BAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.gold),
        title: const Text(
          "PAYMENT",
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [

          const ProfileBackground(),

          const Positioned(
            top: -60,
            right: -40,
            child: GlowCircle(opacity: 0.25),
          ),

          const Positioned(
            bottom: -80,
            left: -50,
            child: GlowCircle(opacity: 0.18),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [

                  PaymentCard(
                    number: number,
                    name: name,
                    exp: exp,
                  ),

                  const SizedBox(height: 20),

                  if (error.isNotEmpty)
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),

                  PaymentInputField(
                    controller: number,
                    hint: "Card Number",
                    maxLength: 16,
                    isNumber: true,
                    onChanged: () => setState(() {}),
                  ),

                  PaymentInputField(
                    controller: name,
                    hint: "Card Holder Name",
                    maxLength: 30,
                    onChanged: () => setState(() {}),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: PaymentInputField(
                          controller: exp,
                          hint: "MM/YY",
                          maxLength: 5,
                          onChanged: () => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: PaymentInputField(
                          controller: cvv,
                          hint: "CVV",
                          maxLength: 3,
                          isNumber: true,
                          onChanged: () => setState(() {}),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  ///  BUTTON
                  AppButton(
                    text: "CONFIRM PAYMENT",
                    backgroundColor: AppColors.gold,
                    onPressed: () {
                      if (!validateFields()) return;

                      widget.onSuccess();
                      Navigator.pop(context, true);

                      AppSnackBar.show(
                        context,
                        "Payment completed successfully ✨",
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}