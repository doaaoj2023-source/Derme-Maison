// import 'package:flutter/material.dart';
// import 'payment_strategy.dart';

// class PaypalStrategy extends PaymentStrategy {
//   final TextEditingController email;

//   PaypalStrategy(this.email);

//   @override
//   String title() => "PAYPAL PAYMENT";

//   @override
//   bool validate() {
//     return email.text.trim().isNotEmpty;
//   }

//   @override
//   void submit(VoidCallback onSuccess) {
//     onSuccess();
//   }
// }