import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Component/luxury_background.dart';
import '../../Component/section_header.dart';
import '../../utils/app_colors.dart';

class ShopSearchFilter extends StatelessWidget {
  final String search;
  final ValueChanged<String> onSearchChanged;

  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const ShopSearchFilter({
    super.key,
    required this.search,
    required this.onSearchChanged,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {"name": "All", "icon": Icons.apps_rounded},
      {"name": "Serum", "icon": Icons.water_drop_rounded},
      {"name": "Cream", "icon": Icons.spa_rounded},
      {"name": "Toner", "icon": Icons.eco_rounded},
      {"name": "Cleanser", "icon": Icons.bubble_chart_rounded},
    ];

    return LuxuryBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            const SizedBox(height: 10),

            /// HEADER 
            const SectionHeader(
              tag: "EXPLORE BEAUTY",
              title: "Skincare Collection",
              subtitle: "Find your perfect skincare routine with luxury care",
            ),

            const SizedBox(height: 14),

            /// SEARCH
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.75),
                        Colors.white.withOpacity(0.55),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  child: TextField(
                    onChanged: onSearchChanged,

                    cursorColor: AppColors.gold,

                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2B1D0E),
                    ),

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search skincare products...",
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xFFC6A77D),
                      ),
                      suffixIcon: search.isNotEmpty
                          ? IconButton(
                              onPressed: () => onSearchChanged(""),
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Color(0xFFC6A77D),
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            /// FILTER TITLE
            Text(
              "SHOP BY CATEGORY",
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color:Color(0xFFC6A77D),
              ),
            ),

            const SizedBox(height: 12),

            /// FILTER LIST
            SizedBox(
              height: 95,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final item = filters[index];
                  final active = selectedFilter == item["name"];

                  return GestureDetector(
                    onTap: () =>
                        onFilterChanged(item["name"] as String),

                    child: Container(
                      width: 90,
                      margin: const EdgeInsets.only(right: 12),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),

                        gradient: active
                            ? const LinearGradient(
                                colors: [
                                  Color(0xFFC6A77D),
                                  Color(0xFFE6C89C),
                                ],
                              )
                            : LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.75),
                                  Colors.white.withOpacity(0.45),
                                ],
                              ),

                        border: Border.all(
                          color: active
                              ? Colors.transparent
                              : Colors.white,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: active
                                ? const Color(0xFFC6A77D)
                                    .withOpacity(0.3)
                                : Colors.black.withOpacity(0.05),
                            blurRadius: active ? 22 : 10,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: active
                                  ? Colors.white
                                  : const Color(0xFFC6A77D),
                            ),
                            child: Icon(
                              item["icon"] as IconData,
                              color: active
                                  ? const Color(0xFFC6A77D)
                                  : Colors.white,
                              size: 22,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            item["name"] as String,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: active
                                  ? Colors.white
                                  : const Color(0xFF4A3A28),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}