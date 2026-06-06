import 'package:flutter/material.dart';

class GlowCircle extends StatelessWidget {
  final double opacity;

  const GlowCircle({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFC6A77D).withOpacity(opacity),
      ),
    );
  }
}