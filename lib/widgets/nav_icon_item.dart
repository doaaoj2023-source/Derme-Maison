import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NavIconItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final bool isActive;
  final VoidCallback onTap;
  final int badgeCount;

  const NavIconItem({
    super.key,
    required this.icon,
    required this.index,
    required this.isActive,
    required this.onTap,
    this.badgeCount = 0,
  });

  Stream<int> _cartCountStream() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return const Stream<int>.empty();

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

  @override
  Widget build(BuildContext context) {
    final isCart = icon == Icons.shopping_cart_rounded;

    return GestureDetector(
      onTap: onTap,
      child: StreamBuilder<int>(
        stream: isCart ? _cartCountStream() : null,
        builder: (context, snapshot) {
          final count = isCart ? (snapshot.data ?? 0) : badgeCount;

          return Stack(
            clipBehavior: Clip.none,
            children: [

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  icon,
                  size: isCart && count == 0 && isActive ? 26 : 22,
                  color: isActive
                      ? Colors.white.withOpacity(0.8)
                      : const Color(0xFFC6A77D),
                ),
              ),

              //  badge
              if (count > 0 && isCart)
                Positioned(
                  right: -6,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      count > 9 ? "9+" : "$count",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}