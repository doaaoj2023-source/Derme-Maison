import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'nav_icon_item.dart';

class NavIconsPill extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool hideCartBadge;

  const NavIconsPill({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.hideCartBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    const String uid = "USER_ID";

    final cartStream = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .snapshots();

    final icons = [
      Icons.shopping_bag_rounded,
      Icons.shopping_cart_rounded,
      Icons.favorite_rounded,
      Icons.person_rounded,
    ];

    return StreamBuilder<QuerySnapshot>(
      stream: cartStream,
      builder: (context, snapshot) {
        int cartCount = 0;

        if (snapshot.hasData) {
          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            cartCount += (data['qty'] ?? 1) as int;
          }
        }

        final isCartPage = currentIndex == 1 || hideCartBadge;

        return ClipRRect(
          borderRadius: BorderRadius.circular(45),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 12,
              sigmaY: 12,
            ),

            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 18),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),

                ///  Soft Elegant Glass (lighter)
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.65),
                    const Color(0xFFF8F3ED).withOpacity(0.40),
                    const Color(0xFFEAD7B7).withOpacity(0.20),
                  ],
                ),

                border: Border.all(
                  color: const Color(0xFFC6A77D).withOpacity(0.30),
                  width: 1.0,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                  BoxShadow(
                    color: const Color(0xFFC6A77D).withOpacity(0.12),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(icons.length, (i) {
                  final isCartIcon =
                      icons[i] == Icons.shopping_cart_rounded;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(horizontal: 10),

                    child: NavIconItem(
                      icon: icons[i],
                      index: i + 1,
                      isActive: currentIndex == i + 1,
                      onTap: () => onTap(i + 1),

                      badgeCount: (hideCartBadge || isCartPage)
                          ? 0
                          : (isCartIcon ? cartCount : 0),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}