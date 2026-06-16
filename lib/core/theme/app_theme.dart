import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.deepSpaceNavy,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.electricBlue,
        secondary: AppColors.cyanGlow,
        tertiary: AppColors.magenta,
        surface: AppColors.cardSurface,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.deepSpaceNavy,
        onSurface: AppColors.textPrimary,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.spaceGroteskTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(color: AppColors.cyanGlow),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.cyanGlow;
          }
          return AppColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.electricBlue.withValues(alpha: 0.5);
          }
          return AppColors.darkViolet;
        }),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.cyanGlow.withValues(alpha: 0.2),
          ),
        ),
      ),
    );
  }
}
