import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class LuxuryBackground extends StatelessWidget {
  final Widget child;

  const LuxuryBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.ivory,
            Colors.white,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80,
            right: -60,
            child: _Glow(180, 0.15),
          ),
          Positioned(
            bottom: -80,
            left: -60,
            child: _Glow(160, 0.5),
          ),
          child,
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  final double size;
  final double opacity;

  const _Glow(this.size, this.opacity);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.gold.withOpacity(opacity),
      ),
    );
  }
}