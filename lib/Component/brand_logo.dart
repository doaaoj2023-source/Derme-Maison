import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  final double size;

  const BrandLogo({
    super.key,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "images/icon.png",
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}