import 'package:flutter/material.dart';
import '../payment/payment_formatter.dart';

class PaymentCard extends StatelessWidget {
  final TextEditingController number;
  final TextEditingController name;
  final TextEditingController exp;

  const PaymentCard({
    super.key,
    required this.number,
    required this.name,
    required this.exp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFD6B37A),
            Color(0xFFF2D6A2),
            Color(0xFFC49A5A),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("VISA",
                  style: TextStyle(color: Colors.white, fontSize: 22)),
              Icon(Icons.credit_card, color: Colors.white70),
            ],
          ),

          const Spacer(),

          Text(
            number.text.isEmpty
                ? "•••• •••• •••• ••••"
                : PaymentFormatter.formatCard(number.text),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),

          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("CARD HOLDER",
                      style: TextStyle(color: Colors.white70, fontSize: 10)),
                  Text(
                    name.text.isEmpty ? "YOUR NAME" : name.text.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("EXPIRES",
                      style: TextStyle(color: Colors.white70, fontSize: 10)),
                  Text(exp.text.isEmpty ? "MM/YY" : exp.text,
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}