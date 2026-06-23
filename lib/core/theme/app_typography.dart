import 'package:flutter/material.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';

class AppTypography {
  const AppTypography._();

  static const String _font = 'DiariaSansPro';

  // ── Dark (cream text on dark bg) ────────────────────────────────────────
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _font, fontSize: 32, fontWeight: FontWeight.w700,
    height: 1.25, color: AppColors.textPrimary,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _font, fontSize: 26, fontWeight: FontWeight.w700,
    height: 1.27, color: AppColors.textPrimary,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _font, fontSize: 22, fontWeight: FontWeight.w700,
    height: 1.3, color: AppColors.textPrimary,
  );
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _font, fontSize: 20, fontWeight: FontWeight.w600,
    height: 1.3, color: AppColors.textPrimary,
  );
  static const TextStyle titleMedium = TextStyle(
    fontFamily: _font, fontSize: 18, fontWeight: FontWeight.w600,
    height: 1.33, color: AppColors.textPrimary,
  );
  static const TextStyle titleSmall = TextStyle(
    fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w600,
    height: 1.375, color: AppColors.textPrimary,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w400,
    height: 1.5, color: AppColors.textPrimary,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w400,
    height: 1.43, color: AppColors.textPrimary,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _font, fontSize: 12, fontWeight: FontWeight.w400,
    height: 1.33, color: AppColors.textSecondary,
  );
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w600,
    height: 1.43, color: AppColors.textPrimary,
  );
  static const TextStyle labelMedium = TextStyle(
    fontFamily: _font, fontSize: 12, fontWeight: FontWeight.w500,
    height: 1.33, color: AppColors.textPrimary,
  );
  static const TextStyle labelSmall = TextStyle(
    fontFamily: _font, fontSize: 11, fontWeight: FontWeight.w500,
    height: 1.45, letterSpacing: 0.5, color: AppColors.textSecondary,
  );

  static TextTheme get darkTextTheme => const TextTheme(
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );

  // ── Light (dark text on cream bg) ───────────────────────────────────────
  static const TextStyle headlineLargeLight = TextStyle(
    fontFamily: _font, fontSize: 32, fontWeight: FontWeight.w700,
    height: 1.25, color: AppColors.textDark,
  );
  static const TextStyle headlineMediumLight = TextStyle(
    fontFamily: _font, fontSize: 26, fontWeight: FontWeight.w700,
    height: 1.27, color: AppColors.textDark,
  );
  static const TextStyle headlineSmallLight = TextStyle(
    fontFamily: _font, fontSize: 22, fontWeight: FontWeight.w700,
    height: 1.3, color: AppColors.textDark,
  );
  static const TextStyle titleLargeLight = TextStyle(
    fontFamily: _font, fontSize: 20, fontWeight: FontWeight.w600,
    height: 1.3, color: AppColors.textDark,
  );
  static const TextStyle titleMediumLight = TextStyle(
    fontFamily: _font, fontSize: 18, fontWeight: FontWeight.w600,
    height: 1.33, color: AppColors.textDark,
  );
  static const TextStyle bodyLargeLight = TextStyle(
    fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w400,
    height: 1.5, color: AppColors.textDark,
  );
  static const TextStyle bodyMediumLight = TextStyle(
    fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w400,
    height: 1.43, color: AppColors.textDark,
  );
  static const TextStyle bodySmallLight = TextStyle(
    fontFamily: _font, fontSize: 12, fontWeight: FontWeight.w400,
    height: 1.33, color: AppColors.textDarkSecondary,
  );
  static const TextStyle labelLargeLight = TextStyle(
    fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w600,
    height: 1.43, color: AppColors.textDark,
  );

  static TextTheme get lightTextTheme => const TextTheme(
    headlineLarge: headlineLargeLight,
    headlineMedium: headlineMediumLight,
    headlineSmall: headlineSmallLight,
    titleLarge: titleLargeLight,
    titleMedium: titleMediumLight,
    bodyLarge: bodyLargeLight,
    bodyMedium: bodyMediumLight,
    bodySmall: bodySmallLight,
    labelLarge: labelLargeLight,
  );
}
