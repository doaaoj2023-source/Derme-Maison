import 'package:flutter/material.dart';

class PaypalHeader extends StatelessWidget {
  const PaypalHeader({super.key});

  static const Color blue = Color(0xFF003087);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.account_balance_wallet,
            color: Colors.white,
            size: 50,
          ),
          SizedBox(height: 10),
          Text(
            "Pay securely with PayPal",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}