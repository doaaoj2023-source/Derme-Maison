import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class FavoritesBackground extends StatelessWidget {
  final Widget? child;

  const FavoritesBackground({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        /// 🌈 MAIN GRADIENT BACKGROUND (from AppColors)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.bg1,
                AppColors.bg2,
                AppColors.bg3,
                AppColors.ivory,
              ],
            ),
          ),
        ),

        /// ✨ TOP ORB
        Positioned(
          top: -120,
          left: -80,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold.withOpacity(0.22),
            ),
          ),
        ),

        /// ✨ BOTTOM ORB
        Positioned(
          bottom: -140,
          right: -90,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkGold.withOpacity(0.15),
            ),
          ),
        ),

        /// CONTENT (safe)
        if (child != null) child!,
      ],
    );
  }
}