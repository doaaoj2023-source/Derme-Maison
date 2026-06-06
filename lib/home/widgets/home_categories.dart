import 'package:flutter/material.dart';

import '../../Component/section_header.dart';
import '../../Component/category_card.dart';
import '../../Component/luxury_background.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  final List<Map<String, String>> cats = const [
    {"title": "Serum", "image": "images/s1.jpg"},
    {"title": "Cleanser", "image": "images/cl1.jpeg"},
    {"title": "Cream", "image": "images/cr1.jpg"},
    {"title": "Toner", "image": "images/t1.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return LuxuryBackground(
      child: Container(
        margin: const EdgeInsets.only(top: 10),

        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 14),
          child: Column(
            children: [

              const SectionHeader(
                tag: "EXPLORE PRODUCTS",
                title: "Skincare Essentials",
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 185,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: cats.length,
                  itemBuilder: (context, i) {
                    final item = cats[i];

                    return CategoryCard(
                      title: item["title"]!,
                      image: item["image"]!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}