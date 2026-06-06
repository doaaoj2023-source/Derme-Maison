import 'package:flutter/material.dart';

class BrandTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const BrandTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  static const textSoft = Color(0xFF9A8F86);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        /// BRAND NAME
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
            color: Color.fromARGB(255, 177, 140, 112),
            shadows: [
              Shadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),

        const SizedBox(height: 3),

        /// SUBTITLE
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 10,
            letterSpacing: 2,
            color: textSoft,
          ),
        ),

        const SizedBox(height: 6),

        /// GOLD LINE
        Container(
          width: 62,
          height: 2,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color(0xFFC6A77D),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }
}