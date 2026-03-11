import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryNavy = Color(0xFF0D1B2A);
  static const Color secondaryGreen = Color(0xFF2ECC71);
  static const Color accentGreen = Color(0xFF16A085);
  static const Color background = Color(0xFFF8F9FA);
  
  static const Color cardLightGreen = Color(0xFFE8F8F5);
  static const Color cardLightBlue = Color(0xFFEAF2F8);
  static const Color cardDarkBackground = Color(0xFF1B263B);
  
  static const Color textMain = Color(0xFF0D1B2A);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textOnDark = Colors.white;
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryNavy,
        background: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textMain,
          fontSize: 24,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textMain,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textMain,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
      ),
    );
  }
}
