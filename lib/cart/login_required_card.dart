import 'package:flutter/material.dart';
import '../login.dart';
import '../utils/app_colors.dart';
import '../Component/luxury_background.dart';
import '../Component/app_button.dart';
import '../Component/app_styles.dart';

class LoginRequiredCard extends StatelessWidget {
  const LoginRequiredCard({super.key});

  BoxDecoration _iconDecoration() {
    return AppStyles.iconCircle;
  }

  @override
  Widget build(BuildContext context) {
    return LuxuryBackground(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Container(
            padding: const EdgeInsets.all(26),
            decoration: AppStyles.card,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: _iconDecoration(),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 34,
                    color: AppColors.gold,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "Sign in required",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: AppColors.darkText,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Please sign in to view your cart and continue shopping.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    height: 1.4,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 22),

                ///  BUTTON
                AppButton(
                  text: "Continue",
                  icon: const Icon(
                    Icons.login_rounded,
                    color: Colors.white,
                  ),
                  backgroundColor: AppColors.gold,
                  textColor: Colors.white,
                  borderRadius: 16,
                  height: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}