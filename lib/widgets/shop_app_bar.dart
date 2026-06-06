import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;
  final VoidCallback? onCartTap;

  const ShopAppBar({
    super.key,
    required this.onBack,
    this.onCartTap,
  });

  static const Color gold = Color(0xFFC6A77D);

  Stream<int> cartCountStream() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Stream<int>.empty();
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .snapshots()
        .map((snapshot) {
      int total = 0;
      for (var doc in snapshot.docs) {
        total += (doc.data()['qty'] ?? 1) as int;
      }
      return total;
    });
  }

  BoxDecoration _circleDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(0.55),
      border: Border.all(color: const Color(0x22C6A77D)),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return Container(
      decoration: _circleDecoration(),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, size: 20, color: gold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),

        child: AppBar(
          // ⭐ أهم تعديل: شفافية كاملة
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false,

          // ❌ نحينا اللون السادة اللي كان يغطي الخلفية
          // shape خليه خفيف أو احذفه (أنا خففته)
          shape: const Border(
            bottom: BorderSide(
              color: Color(0x22C6A77D),
              width: 1,
            ),
          ),

          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: _iconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: onBack,
            ),
          ),

          title: const Text(
            "SHOP",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 4,
              color: gold,
            ),
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: StreamBuilder<int>(
                stream: cartCountStream(),
                builder: (context, snapshot) {
                  final count = snapshot.data ?? 0;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _iconButton(
                        icon: Icons.shopping_bag_rounded,
                        onTap: onCartTap,
                      ),

                      if (count > 0)
                        Positioned(
                          right: -3,
                          top: -3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFC6A77D),
                                  Color(0xFFE6C89C),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              count > 9 ? "9+" : "$count",
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}