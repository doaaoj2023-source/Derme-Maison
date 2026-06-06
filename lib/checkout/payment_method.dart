import 'package:flutter/material.dart';

abstract class PaymentMethod {
  String get id;
  String get title;
  IconData get icon;
}

class CardPayment extends PaymentMethod {
  @override
  String get id => "card";

  @override
  String get title => "Credit / Debit Card";

  @override
  IconData get icon => Icons.credit_card;
}

class PaypalPayment extends PaymentMethod {
  @override
  String get id => "paypal";

  @override
  String get title => "PayPal";

  @override
  IconData get icon => Icons.account_balance_wallet;
}

class CashPayment extends PaymentMethod {
  @override
  String get id => "cash";

  @override
  String get title => "Cash on Delivery";

  @override
  IconData get icon => Icons.local_shipping;
}