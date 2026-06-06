import 'package:flutter/material.dart';

import '../widgets/nav_home_pill.dart';
import '../widgets/nav_icon_pill.dart';

class MainNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool hideCartBadge;

  const MainNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.hideCartBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomePill(
              isActive: currentIndex == 0,
              onTap: () => onTap(0),
            ),

            const SizedBox(width: 14),

            NavIconsPill(
              currentIndex: currentIndex,
              onTap: onTap,
              hideCartBadge: hideCartBadge,
            ),
          ],
        ),
      ),
    );
  }
}