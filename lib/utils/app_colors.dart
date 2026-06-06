import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ================= PRIMARY THEME =================
  static const Color gold = Color(0xFFC6A77D);
  static const Color darkGold = Color(0xFF8E6B3D);

  // ================= PAYPAL =================
  static const Color paypalBlue = Color(0xFF003087);

  // ================= BACKGROUNDS =================
  static const Color background = Color(0xFFF7F3EE);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color bg1 = Color(0xFFFAF7F2);
  static const Color bg2 = Color(0xFFF1E6D6);
  static const Color bg3 = Color(0xFFE7D7BE);

  static const Color ivory = Color(0xFFF6F1E8);
  static const Color softWhite = Color(0xFFF6F0EA);

  // ================= TEXT =================
  static const Color darkText = Color(0xFF2B1D0E);
  static const Color mutedText = Color(0xFF8E7F73);
  static const Color whiteText = Colors.white;

  // ================= SHADOWS =================
  static Color get shadow => Colors.black.withOpacity(0.08);
  static Color get shadowLight => Colors.black.withOpacity(0.05);

  // ================= GLASS EFFECT =================
  static Color get glassBorder => Colors.white.withOpacity(0.6);
  static Color get glassWhite => Colors.white.withOpacity(0.75);
  static Color get glassWhiteSoft => Colors.white.withOpacity(0.45);

  // ================= CARDS =================
  static Color get cardBg => Colors.white.withOpacity(0.85);
  static Color get heroCardBg => Colors.white.withOpacity(0.55); // FIX ERROR
  static Color get heroBorder => Colors.white.withOpacity(0.6);
  static Color get heroShadow => Colors.black.withOpacity(0.06);

  // ================= LEGACY FIX (ERROR FIX) =================
  static const Color pieceText = Color(0xFFC6A77D); // FIX ERROR
  static const Color appBarTitle = gold;

  // ================= STATUS COLORS =================
  static const Color dangerRed = Colors.red;
  static const Color dangerRedSoft = Colors.redAccent;

  // ================= UI MAIN COLORS =================
  static const Color primaryButton = gold;
  static const Color secondaryButton = paypalBlue;
}