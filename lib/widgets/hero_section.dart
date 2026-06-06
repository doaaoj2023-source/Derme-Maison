import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {

  final PageController _pageController = PageController();

  final List<String> videos = [
    "assets/videos/v1.mp4",
    "assets/videos/v2.mp4",
  ];

  late List<VideoPlayerController> controllers;

  int current = 0;

  Timer? timer;

  /// ✨ HERO INTRO
  late AnimationController introController;

  late Animation<double> fade;
  late Animation<Offset> slide;
  late Animation<double> scale;

  bool ready = false;

  @override
  void initState() {
    super.initState();

    /// 🎬 INTRO
    introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: introController,
        curve: Curves.easeOut,
      ),
    );

    slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: introController,
        curve: Curves.easeOutCubic,
      ),
    );

    scale = Tween<double>(
      begin: 1.04,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: introController,
        curve: Curves.easeOutCubic,
      ),
    );

    /// 🎥 VIDEO CONTROLLERS
    controllers = videos.map((video) {
      return VideoPlayerController.asset(video);
    }).toList();

    _initVideos();
  }

  Future<void> _initVideos() async {

    for (final c in controllers) {

      await c.initialize();

      await c.setLooping(true);

      await c.setVolume(0);
    }

    /// 🔥 شغل أول فيديو
    await controllers[0].play();

    ready = true;

    if (mounted) {
      setState(() {});
    }

    /// 🎬 START INTRO
    introController.forward();

    /// 🔁 AUTO SLIDE
    _startAutoSlide();
  }

  /// 🔥 AUTO SLIDE
  void _startAutoSlide() {

    timer?.cancel();

    /// ⏱ مدة كل فيديو
    final duration =
        current == 0
            ? const Duration(seconds: 4)
            : const Duration(seconds: 16);

    timer = Timer(duration, () async {

      if (!mounted) return;

      /// ⏸ وقف الحالي
      await controllers[current].pause();

      current = (current + 1) % videos.length;

      /// ▶ شغل الجديد
      await controllers[current].play();

      if (mounted) {
        setState(() {});
      }

      /// ✨ SLIDE ANIMATION
      _pageController.animateToPage(
        current,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutCubic,
      );

      /// 🔁 LOOP
      _startAutoSlide();
    });
  }

  @override
  void dispose() {

    timer?.cancel();

    introController.dispose();

    _pageController.dispose();

    for (final c in controllers) {
      c.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// 🔥 LOADING
    if (!ready ||
        controllers.isEmpty ||
        !controllers[0].value.isInitialized) {

      return Container(
        height: 390,
        width: double.infinity,
        color: Colors.black,

        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return FadeTransition(
      opacity: fade,

      child: SlideTransition(
        position: slide,

        child: ScaleTransition(
          scale: scale,

          child: SizedBox(
            height: 390,
            width: double.infinity,

            child: Stack(
              children: [

                /// 🎥 VIDEO SLIDER
                PageView.builder(
                  controller: _pageController,
                  itemCount: controllers.length,

                  physics:
                      const NeverScrollableScrollPhysics(),

                  onPageChanged: (i) {
                    setState(() {
                      current = i;
                    });
                  },

                  itemBuilder: (context, i) {

                    final c = controllers[i];

                    return Stack(
                      fit: StackFit.expand,
                      children: [

                        /// VIDEO
                        FittedBox(
                          fit: BoxFit.cover,

                          child: SizedBox(
                            width: c.value.size.width,
                            height: c.value.size.height,
                            child: VideoPlayer(c),
                          ),
                        ),

                        /// 🌫 SOFT BLUR
                        BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 1.5,
                            sigmaY: 1.5,
                          ),

                          child: Container(
                            color: Colors.black.withValues(
                              alpha: 0.08,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                /// 🌑 OVERLAY
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,

                      colors: [
                        Color(0xEE000000),
                        Color(0x66000000),
                        Colors.transparent,
                      ],

                      stops: [0.0, 0.4, 1],
                    ),
                  ),
                ),

                /// 💎 TEXT CONTENT
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 95,

                  child: AnimatedSwitcher(
                    duration:
                        const Duration(milliseconds: 600),

                    transitionBuilder:
                        (child, animation) {

                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        ),

                        child:
                            TweenAnimationBuilder<double>(
                          tween: Tween(
                            begin: 14,
                            end: 0,
                          ),

                          duration:
                              const Duration(milliseconds: 650),

                          builder:
                              (context, value, child) {

                            return Transform.translate(
                              offset: Offset(0, value),
                              child: child,
                            );
                          },

                          child: child,
                        ),
                      );
                    },

                    child: Column(
                      key: ValueKey(current),
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        /// LABEL
                        Text(
                          current == 0
                              ? "NEW COLLECTION"
                              : "ESSENTIAL CARE",

                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontSize: 10,
                            letterSpacing: 3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// TITLE
                        Text(
                          current == 0
                              ? "Effortless beauty."
                              : "Pure simplicity.",

                          style:
                              GoogleFonts.playfairDisplay(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// SUBTEXT
                        SizedBox(
                          width: 260,

                          child: Text(
                            "Minimal skincare crafted with elegance and clarity.",

                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// ⚪ SLIDER INDICATORS
                Positioned(
                  bottom: 28,
                  left: 0,
                  right: 0,

                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: List.generate(
                      videos.length,
                      (i) {

                        final active = current == i;

                        return AnimatedContainer(
                          duration:
                              const Duration(milliseconds: 350),

                          margin:
                              const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),

                          width: active ? 28 : 7,
                          height: 7,

                          decoration: BoxDecoration(
                            color: active
                                ? Colors.white
                                : Colors.white30,

                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}