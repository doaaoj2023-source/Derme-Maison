import 'package:flutter/material.dart';

class SliderDots extends StatelessWidget {
  final int length;
  final int currentIndex;

  const SliderDots({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) {
        final active = i == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 18 : 7,
          height: 7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: active
                ? const Color(0xFFC6A77D)
                : Colors.white.withOpacity(0.5),
          ),
        );
      }),
    );
  }
}