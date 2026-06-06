import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../profile/widgets/profile_user_card.dart';
import '../cart/login_required_card.dart';
import '../utils/app_colors.dart';
import '../checkout/app_snackbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _handleAction(BuildContext context, String title) {
    AppSnackBar.show(
      context,
      title,
      message: "$title opened successfully",
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const LoginRequiredCard();
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "PROFILE",
          style: TextStyle(
            color: AppColors.appBarTitle,
            fontWeight: FontWeight.w700,
            letterSpacing: 3,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.appBarTitle,
        ),
        centerTitle: true,
      ),

      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.bg1,
                  AppColors.softWhite,
                  AppColors.bg2,
                ],
              ),
            ),
          ),

          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withOpacity(0.18),
              ),
            ),
          ),

          Positioned(
            bottom: -140,
            left: -90,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.glassWhite,
              ),
            ),
          ),

          SafeArea(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data =
                    snapshot.data!.data() as Map<String, dynamic>;

                final role = data['role'] ?? 'user';

                return ProfileUserCard(
                  user: user,
                  role: role,

                  onAdminTap: () =>
                      _handleAction(context, "Admin Dashboard"),

                  onSettingsTap: () =>
                      _handleAction(context, "Settings"),

                  onDashboardTap: () =>
                      _handleAction(context, "Dashboard"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}