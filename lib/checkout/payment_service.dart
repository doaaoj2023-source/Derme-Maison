import 'package:flutter/material.dart';
import '../screens/card_payment_page.dart';
import '../screens/paypal_payment_page.dart';
import '../screens/cash_on_delivery_page.dart';
import 'payment_type.dart';

class PaymentService {
  static Future<bool?> openPayment(
    BuildContext context,
    PaymentType type,
  ) async {
    switch (type) {
      case PaymentType.card:
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CardPaymentPage(onSuccess: () {}),
          ),
        );

      case PaymentType.paypal:
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PaypalPaymentPage(onSuccess: () {}),
          ),
        );

      case PaymentType.cash:
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CashOnDeliveryPage(onSuccess: () {}),
          ),
        );
    }
  }
}