import 'package:flutter/material.dart';

import '../../Component/brand_logo.dart';
import '../../Component/brand_title.dart';
import '../../utils/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 72,

      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              AppColors.background,
              const Color(0xFFF1E6DC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),

        child: SafeArea(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [

                /// LOGO
                BrandLogo(size: 40),

                SizedBox(width: 12),

                /// TEXT
                BrandTitle(
                  title: "DERMÉ MAISON",
                  subtitle: "PARISIAN SKIN RITUALS",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}