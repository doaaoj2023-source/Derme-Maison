import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashLoader extends StatelessWidget {
  final AnimationController controller;

  const SplashLoader({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      child: Column(
        children: [

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFC6A77D)
                      .withOpacity(0.38),
                  blurRadius: 16,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: controller.value,
                    minHeight: 4,
                    backgroundColor: Colors.white12,
                    valueColor:
                        const AlwaysStoppedAnimation(
                      Color(0xFFC6A77D),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Preparing your experience",
            style: GoogleFonts.cormorantGaramond(
              color: Colors.white70,
              fontSize: 15,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}