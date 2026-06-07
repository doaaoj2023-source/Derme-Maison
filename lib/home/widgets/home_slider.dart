import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();

  final List<String> videos = [
    "assets/videos/mv.mp4",
    "assets/videos/v1.mp4",
  ];

  late List<VideoPlayerController> controllers;

  int current = 0;
  Timer? timer;

  late AnimationController intro;
  late Animation<double> fade;
  late Animation<Offset> slide;

  @override
  void initState() {
    super.initState();

    intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    fade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: intro, curve: Curves.easeOut),
    );

    slide = Tween(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: intro, curve: Curves.easeOutCubic),
    );

    controllers =
        videos.map((v) => VideoPlayerController.asset(v)).toList();

    _init();
  }

  Future<void> _init() async {
    for (final c in controllers) {
      await c.initialize();
      await c.setLooping(true);
      await c.setVolume(0);
    }

    await controllers[0].play();

    intro.forward();
    _startAuto();
    setState(() {});
  }

  void _startAuto() {
    timer?.cancel();

    timer = Timer(const Duration(seconds: 6), () async {
      if (!mounted) return;

      await controllers[current].pause();

      current = (current + 1) % controllers.length;

      await controllers[current].play();

      _pageController.animateToPage(
        current,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutCubic,
      );

      setState(() {});
      _startAuto();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    intro.dispose();
    _pageController.dispose();
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controllers.isEmpty || !controllers[0].value.isInitialized) {
      return const SizedBox(
        height: 380,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: SizedBox(
          height: 380,
          child: Stack(
            children: [

              ///  VIDEO
              PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controllers.length,
                itemBuilder: (context, i) {
                  final c = controllers[i];

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: c.value.size.width,
                          height: c.value.size.height,
                          child: VideoPlayer(c),
                        ),
                      ),

                      /// 🌑 DARK BASE
                      Container(
                        color: Colors.black.withOpacity(0.15),
                      ),
                    ],
                  );
                },
              ),

              ///  BIG GLASS GRADIENT (MAIN LAYER — IMPORTANT)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.75),
                        Colors.black.withOpacity(0.35),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              ///  TEXT (داخل التدرج مش فوقه)
              Positioned(
                left: 22,
                right: 22,
                bottom: 70,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _Caption(
                    key: ValueKey(current),
                    index: current,
                  ),
                ),
              ),

              ///  INDICATORS
              Positioned(
                bottom: 18,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(videos.length, (i) {
                    final active = i == current;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: active ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: active
                            ? const Color(0xFFC6A77D)
                            : Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///  CAPTION (خفيف + داخل الجو مش فوقه)
class _Caption extends StatelessWidget {
  final int index;

  const _Caption({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        Text(
          index == 0 ? "NEW COLLECTION" : "SIGNATURE CARE",
          style: GoogleFonts.inter(
            fontSize: 10,
            letterSpacing: 4,
            color: const Color(0xFFC6A77D),
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          index == 0
              ? "Effortless Beauty"
              : "Timeless Rituals",
          style: GoogleFonts.playfairDisplay(
            fontSize: 30,
            height: 1.05,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 25,
              )
            ],
          ),
        ),

        const SizedBox(height: 6),

        Text(
          index == 0
              ? "Luxury skincare that reveals natural glow with purity."
              : "A refined ritual of elegance, balance and softness.",
          style: GoogleFonts.inter(
            fontSize: 12,
            height: 1.6,
            color: Colors.white.withOpacity(0.75),
          ),
        ),
      ],
    );
  }
}