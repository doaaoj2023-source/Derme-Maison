import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppStyles {
  AppStyles._();

  // =========================
  // 🟫 CARD STYLE (glass)
  // =========================
  static BoxDecoration card = BoxDecoration(
    borderRadius: BorderRadius.circular(26),
    color: AppColors.glassWhite,
    border: Border.all(color: AppColors.glassBorder),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: 25,
        offset: const Offset(0, 12),
      ),
    ],
  );

  // =========================
  // 🌫 GLASS BACKGROUND CARD (lighter)
  // =========================
  static BoxDecoration glassCard = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.glassWhite.withOpacity(0.22),
        AppColors.glassWhiteSoft.withOpacity(0.10),
        AppColors.bg2.withOpacity(0.18),
      ],
    ),
    border: Border.all(color: AppColors.glassBorder),
  );

  // =========================
  // 🔘 PRIMARY BUTTON (gold gradient)
  // =========================
  static BoxDecoration primaryButton = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    gradient: const LinearGradient(
      colors: [
        AppColors.gold,
        AppColors.darkGold,
      ],
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.gold.withOpacity(0.25),
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  );

  // =========================
  // ⚪ ICON CIRCLE (gold soft)
  // =========================
  static BoxDecoration iconCircle = BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.gold.withOpacity(0.15),
  );

  // =========================
  // ➕ SMALL CIRCLE BUTTON (add/remove)
  // =========================
  static BoxDecoration circleButton = BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.white.withOpacity(0.35),
  );

  static BoxDecoration circleButtonPrimary = BoxDecoration(
    shape: BoxShape.circle,
    gradient: const LinearGradient(
      colors: [
        AppColors.gold,
        AppColors.darkGold,
      ],
    ),
  );

  // =========================
  // 🟥 DELETE BUTTON STYLE
  // =========================
  static BoxDecoration deleteButton = BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.red.withOpacity(0.06),
  );

  // =========================
  // 📦 PRICE TAG / BADGE
  // =========================
  static BoxDecoration priceBadge = BoxDecoration(
    color: AppColors.gold.withOpacity(0.10),
    borderRadius: BorderRadius.circular(20),
  );

  // =========================
  // 🌟 ACCENT STRIP (cart item)
  // =========================
  static BoxDecoration accentStrip = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0x88C6A77D),
        Color(0xFF7A5A30),
      ],
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      bottomLeft: Radius.circular(30),
    ),
  );
}