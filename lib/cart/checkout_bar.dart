import 'package:flutter/material.dart';
import '../screens/checkout_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckoutBar extends StatelessWidget {
  final double total;

  const CheckoutBar({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    final safeTotal = total.isNaN || total.isNegative ? 0.0 : total;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),

        /// 🌟 GLASS LUXURY EFFECT
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.75),
            Colors.white.withOpacity(0.45),
            const Color(0xFFF6F1E8).withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        border: Border.all(
          color: Colors.white.withOpacity(0.6),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Row(
        children: [

          /// 💰 TOTAL
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "TOTAL",
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color:Color(0xFFC6A77D),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "\$${safeTotal.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF8E6B3D),
                ),
              ),
            ],
          ),

          const Spacer(),

          /// 🚀 PREMIUM CHECKOUT BUTTON (WITH ICON)
          GestureDetector(
            onTap: () {
              final user = FirebaseAuth.instance.currentUser;

              if (user == null) {
                Navigator.pushNamed(context, '/login');
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CheckoutPage(),
                ),
              );
            },

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFC6A77D),
                    Color(0xFF8E6B3D),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),

                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFC6A77D).withOpacity(0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [

                  /// 💳 ICON (payment vibe)
                  Icon(
                    Icons.credit_card_rounded,
                    color: Colors.white,
                    size: 20,
                  ),

                  SizedBox(width: 8),

                  Text(
                    "CHECKOUT",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
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