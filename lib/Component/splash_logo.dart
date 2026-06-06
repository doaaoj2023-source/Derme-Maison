import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashLogo extends StatelessWidget {
  final Animation<double> fade;
  final Animation<double> scale;
  final Animation<double> textFade;
  final Animation<Offset> textSlide;
  final bool showText;

  const SplashLogo({
    super.key,
    required this.fade,
    required this.scale,
    required this.textFade,
    required this.textSlide,
    required this.showText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        FadeTransition(
          opacity: fade,
          child: ScaleTransition(
            scale: scale,
            child: Image.asset(
              "images/icon.png",
              width: 150,
            ),
          ),
        ),

        const SizedBox(height: 30),

        if (showText)
          SlideTransition(
            position: textSlide,
            child: FadeTransition(
              opacity: textFade,
              child: Column(
                children: [

                  Text(
                    "Dermé Maison",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 34,
                      color: Colors.white,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "PARISIAN SKINCARE HOUSE",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 15,
                      color: Colors.white,
                      letterSpacing: 5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}