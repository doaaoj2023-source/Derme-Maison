import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'welcome_screen.dart';
import './Component/splash_loader.dart';
import './Component/splash_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _loaderController;

  late Animation<double> _logoFade;
  late Animation<double> _logoScale;

  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;

  bool showText = false;
  bool showWelcome = false;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _logoFade = Tween<double>(begin: 0, end: 1)
        .animate(_logoController);

    _logoScale = Tween<double>(begin: 0.72, end: 1)
        .animate(_logoController);

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _textFade = Tween<double>(begin: 0, end: 1)
        .animate(_textController);

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(_textController);

    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _logoController.forward();

    Future.delayed(
      const Duration(milliseconds: 2400),
      () {
        setState(() => showText = true);
        _textController.forward();
      },
    );

    Timer(const Duration(seconds: 7), () {
      setState(() => showWelcome = true);
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// BACKGROUND (نفسه 100%)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 900),
            opacity: showWelcome ? 0 : 1,
            child: SizedBox.expand(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "images/min1.jpg",
                    fit: BoxFit.cover,
                  ),

                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 6,
                      sigmaY: 6,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.15),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// CONTENT (نفس الشكل بالضبط)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: showWelcome ? 0 : 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SplashLogo(
                    fade: _logoFade,
                    scale: _logoScale,
                    textFade: _textFade,
                    textSlide: _textSlide,
                    showText: showText,
                  ),

                  const SizedBox(height: 44),

                  SplashLoader(
                    controller: _loaderController,
                  ),
                ],
              ),
            ),
          ),

          /// WELCOME (نفسه)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 1200),
            opacity: showWelcome ? 1 : 0,
            child: const WelcomeScreen(),
          ),
        ],
      ),
    );
  }
}