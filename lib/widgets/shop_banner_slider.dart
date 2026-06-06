import 'package:flutter/material.dart';

import '../../Component/slider_dots.dart';
import '../../Component/banner_card.dart';

class ShopBannerSlider extends StatefulWidget {
  const ShopBannerSlider({super.key});

  @override
  State<ShopBannerSlider> createState() => _ShopBannerSliderState();
}

class _ShopBannerSliderState extends State<ShopBannerSlider> {
  final PageController controller = PageController(viewportFraction: 0.92);
  int currentIndex = 0;

  final List<Map<String, String>> banners = const [
    {
      "title": "Up to 50% Off",
      "subtitle": "Selected skincare essentials at special prices",
      "image": "images/cr4.jpg",
    },
    {
      "title": "New Season Drop",
      "subtitle": "Clean formulas for your daily skincare routine",
      "image": "images/p4.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Roboto',
            ),
      ),
      child: SizedBox(
        height: 220,
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              onPageChanged: (i) => setState(() => currentIndex = i),
              itemCount: banners.length,
              itemBuilder: (context, i) {
                final item = banners[i];

                return BannerCard(
                  title: item["title"]!,
                  subtitle: item["subtitle"]!,
                  image: item["image"]!,
                );
              },
            ),

            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: SliderDots(
                length: banners.length,
                currentIndex: currentIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}