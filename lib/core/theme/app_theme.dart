import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyba_bonus/core/theme/app_colors.dart';
import 'package:skyba_bonus/core/theme/app_typography.dart';

class AppTheme {
  const AppTheme._();

  // Main app — dark background
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'DiariaSansPro',
        colorScheme: const ColorScheme.dark(
          primary: AppColors.cream,
          onPrimary: AppColors.primary,
          secondary: AppColors.darkSurface2,
          onSecondary: AppColors.textPrimary,
          surface: AppColors.darkSurface,
          onSurface: AppColors.textPrimary,
          error: AppColors.error,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: AppColors.darkBg,
        textTheme: AppTypography.darkTextTheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBg,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          titleTextStyle: TextStyle(
            fontFamily: 'DiariaSansPro',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          iconTheme: IconThemeData(color: AppColors.textPrimary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.cream,
            foregroundColor: AppColors.primary,
            disabledBackgroundColor: Color(0xFF5A4030),
            disabledForegroundColor: Color(0xFF9A8878),
            minimumSize: const Size(double.infinity, 56),
            shape: const StadiumBorder(),
            textStyle: const TextStyle(
              fontFamily: 'DiariaSansPro',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.cream,
            minimumSize: const Size(double.infinity, 56),
            shape: const StadiumBorder(),
            side: const BorderSide(color: AppColors.cream, width: 1.5),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.cream,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkSurface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.borderDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.borderDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.cream, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          hintStyle: TextStyle(
            fontFamily: 'DiariaSansPro',
            fontSize: 14,
            color: AppColors.textHint,
          ),
          labelStyle: TextStyle(
            fontFamily: 'DiariaSansPro',
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 1,
        ),
        cardTheme: CardThemeData(
          color: AppColors.darkSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.borderDark),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        ),
      );

  // Auth screens — cream background (applied per-screen)
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'DiariaSansPro',
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          onPrimary: AppColors.cream,
          secondary: AppColors.darkSurface2,
          onSecondary: AppColors.textPrimary,
          surface: AppColors.creamSurface,
          onSurface: AppColors.textDark,
          error: AppColors.error,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: AppColors.creamBg,
        textTheme: AppTypography.lightTextTheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.creamBg,
          foregroundColor: AppColors.textDark,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.cream,
            disabledBackgroundColor: const Color(0xFFC0B8AE),
            disabledForegroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: const StadiumBorder(),
            textStyle: const TextStyle(
              fontFamily: 'DiariaSansPro',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 56),
            shape: const StadiumBorder(),
            side: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.creamSurface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.borderCream),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.borderCream),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          hintStyle: const TextStyle(
            fontFamily: 'DiariaSansPro',
            fontSize: 14,
            color: AppColors.textDarkHint,
          ),
          labelStyle: const TextStyle(
            fontFamily: 'DiariaSansPro',
            fontSize: 14,
            color: AppColors.textDarkSecondary,
          ),
          errorStyle: TextStyle(
            fontFamily: 'DiariaSansPro',
            fontSize: 12,
            color: AppColors.error,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.borderCream,
          thickness: 1,
          space: 1,
        ),
      );
}
