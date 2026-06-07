import 'package:flutter/material.dart';

class HomePill extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const HomePill({
    super.key,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFFC6A77D);
    final Color inactiveColor = Colors.white;

    final Color bgColor = isActive ? activeColor : inactiveColor;

    ///  inversion logic
    final Color iconColor =
        isActive ? Colors.white : const Color(0xFFC6A77D);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,

        width: 50,
        height: 50,

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Icon(
          Icons.home,
          color: iconColor,
          size: 24,
        ),
      ),
    );
  }
}