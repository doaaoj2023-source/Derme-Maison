import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// TAG
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFC6A77D).withOpacity(0.18),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            tag,
            style: GoogleFonts.inter(
              fontSize: 11,
              letterSpacing: 4,
              color: const Color(0xFFC6A77D),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 8),

        /// TITLE
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFC6A77D),
          ),
        ),

        /// SUBTITLE 
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}