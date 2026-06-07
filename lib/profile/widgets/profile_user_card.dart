import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'profile_role_badge.dart';
import 'profile_buttons.dart';

class ProfileUserCard extends StatelessWidget {
  final User user;
  final String role;

  
  final VoidCallback? onAdminTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onDashboardTap;

  const ProfileUserCard({
    super.key,
    required this.user,
    required this.role,
    this.onAdminTap,
    this.onSettingsTap,
    this.onDashboardTap,
  });

  static const Color gold = Color(0xFFC6A77D);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 90, 20, 20),
      child: Column(
        children: [

          /// PROFILE CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
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

            child: Column(
              children: [

                /// AVATAR
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: gold.withOpacity(0.25),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: gold,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  user.email ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B2B1A),
                  ),
                ),

                const SizedBox(height: 12),

                ProfileRoleBadge(role: role),
              ],
            ),
          ),

          const SizedBox(height: 25),

          /// BUTTONS
          ProfileButtons(
            role: role,
            user: user,
          ),
        ],
      ),
    );
  }
}