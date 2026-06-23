import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // ── Backward-compat aliases ─────────────────────────────────────────────
  static const Color secondary = Color(0xFF8B6B4A);
  static const Color secondaryLight = Color(0xFFA88560);

  // ── Main app (dark background) ──────────────────────────────────────────
  static const Color darkBg = Color(0xFF34261E);       // main scaffold (Figma Brown/900)
  static const Color darkSurface = Color(0xFF42312A);  // cards on dark bg
  static const Color darkSurface2 = Color(0xFF513D34); // slightly lighter

  // ── Auth screens (cream background) ────────────────────────────────────
  static const Color creamBg = Color(0xFFFEFDEB);      // Figma Light beige 900
  static const Color creamSurface = Color(0xFFFFFFFF);

  // ── Brand alias ─────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF34261E);      // dark brown (Figma)
  static const Color primaryLight = Color(0xFF42312A);
  static const Color primaryDark = Color(0xFF231810);
  static const Color cream = Color(0xFFFEFDEB);        // cream accent (Figma)
  static const Color scaffoldBackground = darkBg;
  static const Color surface = darkSurface;
  static const Color surfaceVariant = darkSurface2;

  // ── Text on dark background ─────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFFEFDEB);
  static const Color textSecondary = Color(0xFFBFB09A);
  static const Color textHint = Color(0xFF8A7A6A);
  static const Color textOnPrimary = Color(0xFFFEFDEB);
  static const Color textOnSecondary = Color(0xFFFEFDEB);

  // ── Text on cream background ────────────────────────────────────────────
  static const Color textDark = Color(0xFF34261E);
  static const Color textDarkSecondary = Color(0xFF8C7B6B);
  static const Color textDarkHint = Color(0xFFBAAB97);

  // ── Semantic colors ─────────────────────────────────────────────────────
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFFFEBEE);
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color warning = Color(0xFFF57C00);
  static const Color warningLight = Color(0xFFFFF3E0);
  static const Color info = Color(0xFF1976D2);
  static const Color infoLight = Color(0xFFE3F2FD);

  // ── Borders ─────────────────────────────────────────────────────────────
  static const Color borderDark = Color(0xFF5A4636);   // border on dark bg
  static const Color borderCream = Color(0xFFD4C4A8);  // border on cream bg
  static const Color divider = Color(0xFF5A4636);
  static const Color border = borderDark;
  static const Color borderLight = Color(0xFF4A3828);

  // ── Bottom nav ──────────────────────────────────────────────────────────
  static const Color bottomNavBg = cream;
  static const Color bottomNavActive = primary;
  static const Color bottomNavInactive = Color(0xFFB0A898);

  // ── Bonus card gradient ─────────────────────────────────────────────────
  static const List<Color> bonusCardGradient = [
    Color(0xFF513D34),
    Color(0xFF34261E),
  ];

  // ── Shimmer ─────────────────────────────────────────────────────────────
  static const Color shimmerBase = Color(0xFF42312A);
  static const Color shimmerHighlight = Color(0xFF513D34);
}
