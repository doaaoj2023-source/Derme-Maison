// import 'package:flutter/material.dart';
// import 'payment_strategy.dart';

// class CashStrategy extends PaymentStrategy {
//   final TextEditingController address;
//   final TextEditingController phone;

//   CashStrategy(this.address, this.phone);

//   @override
//   String title() => "CASH ON DELIVERY";

//   @override
//   bool validate() {
//     return address.text.trim().isNotEmpty &&
//         phone.text.trim().isNotEmpty;
//   }

//   @override
//   void submit(VoidCallback onSuccess) {
//     onSuccess();
//   }
// }