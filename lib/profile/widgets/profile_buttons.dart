import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../login.dart';
import '../../../screens/manage_products.dart';

class ProfileButtons extends StatelessWidget {
  final String role;
  final User user;

  const ProfileButtons({
    super.key,
    required this.role,
    required this.user,
  });

  static const Color gold = Color(0xFFC6A77D);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// ADMIN BUTTONS
        if (role == 'admin') ...[
          _btn(
            context,
            Icons.dashboard,
            "Admin Dashboard",
            () {
              /// Coming soon message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Admin Dashboard is currently under development",
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),

          _btn(
            context,
            Icons.inventory_2,
            "Manage Products",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ManageProductsPage(),
                ),
              );
            },
          ),
        ],

        /// SETTINGS
        _btn(
          context,
          Icons.settings,
          "Settings",
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Settings feature will be available soon",
                ),
              ),
            );
          },
        ),

        /// LOGOUT
        _btn(
          context,
          Icons.logout,
          "Logout",
          () async {
            await FirebaseAuth.instance.signOut();

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          },
        ),
      ],
    );
  }

  ///  BUTTON DESIGN (UNCHANGED)
  Widget _btn(
    BuildContext context,
    IconData icon,
    String text,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,

        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),

            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFFCF8),
                Color(0xFFF5E9D8),
              ],
            ),

            border: Border.all(
              color: const Color(0xFFE6D2B5),
              width: 1.2,
            ),
          ),

          child: Row(
            children: [

              Icon(
                icon,
                color: gold,
              ),

              const SizedBox(width: 14),

              Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3B2B1A),
                ),
              ),

              const Spacer(),

              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Color(0xFFC6A77D),
              ),
            ],
          ),
        ),
      ),
    );
  }
}