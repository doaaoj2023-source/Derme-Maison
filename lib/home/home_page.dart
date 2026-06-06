import 'package:flutter/material.dart';

import 'widgets/home_header.dart';
import 'widgets/home_slider.dart';
import 'widgets/home_categories.dart';
import 'widgets/home_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [

        const HomeHeader(),

        const SliverToBoxAdapter(
          child: HomeSlider(),
        ),

        const SliverToBoxAdapter(
          child: HomeCategories(),
        ),

        /// 💥 IMPORTANT FIX HERE
        SliverToBoxAdapter(
          child: HomeProducts(),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 30),
        ),
      ],
    );
  }
}