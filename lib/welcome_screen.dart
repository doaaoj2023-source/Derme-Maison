import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'store.dart';
import '../utils/app_colors.dart';
import '../Component/app_button.dart';
import '../Component/slider_dots.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController controller = PageController();
  int index = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "images/min1.jpg",
      "title": "Timeless Beauty",
      "subtitle": "Skincare inspired by Parisian elegance.",
    },
    {
      "image": "images/cart.jpg",
      "title": "Pure Ritual",
      "subtitle": "Science meets luxury in every formula.",
    },
    {
      "image": "images/s1.jpg",
      "title": "Glow Naturally",
      "subtitle": "Reveal your skin’s quiet radiance.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemCount: pages.length,
        onPageChanged: (value) => setState(() => index = value),
        itemBuilder: (context, i) {
          return Stack(
            fit: StackFit.expand,
            children: [

              Image.asset(pages[i]["image"]!, fit: BoxFit.cover),

              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.white24,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 450,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black26,
                        Colors.black87,
                      ],
                      stops: [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Spacer(),

                    Text(
                      pages[i]["title"]!,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 38,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      pages[i]["subtitle"]!,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 18,
                        color: Colors.white70,
                        height: 1.7,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 40),

                    ///  BUTTON (UNIFIED)
                    AppButton(
                      text: index == pages.length - 1
                          ? "ENTER STORE"
                          : "CONTINUE",
                      backgroundColor: AppColors.gold,
                      onPressed: () {
                        if (index == pages.length - 1) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const StoreScreen(),
                            ),
                          );
                        } else {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 30),

                    ///  DOTS (UNIFIED)
                    SliderDots(
                      length: pages.length,
                      currentIndex: index,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}