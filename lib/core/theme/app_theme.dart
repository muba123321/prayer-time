import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceContainerHighest: AppColors.surfaceVariant,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.withColor(
          AppTextStyles.titleLarge,
          AppColors.onPrimary,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.onPrimary,
          size: 24,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.withColor(
          AppTextStyles.displayLarge,
          AppColors.textPrimary,
        ),
        displayMedium: AppTextStyles.withColor(
          AppTextStyles.displayMedium,
          AppColors.textPrimary,
        ),
        displaySmall: AppTextStyles.withColor(
          AppTextStyles.displaySmall,
          AppColors.textPrimary,
        ),
        headlineLarge: AppTextStyles.withColor(
          AppTextStyles.headlineLarge,
          AppColors.textPrimary,
        ),
        headlineMedium: AppTextStyles.withColor(
          AppTextStyles.headlineMedium,
          AppColors.textPrimary,
        ),
        headlineSmall: AppTextStyles.withColor(
          AppTextStyles.headlineSmall,
          AppColors.textPrimary,
        ),
        titleLarge: AppTextStyles.withColor(
          AppTextStyles.titleLarge,
          AppColors.textPrimary,
        ),
        titleMedium: AppTextStyles.withColor(
          AppTextStyles.titleMedium,
          AppColors.textPrimary,
        ),
        titleSmall: AppTextStyles.withColor(
          AppTextStyles.titleSmall,
          AppColors.textPrimary,
        ),
        bodyLarge: AppTextStyles.withColor(
          AppTextStyles.bodyLarge,
          AppColors.textPrimary,
        ),
        bodyMedium: AppTextStyles.withColor(
          AppTextStyles.bodyMedium,
          AppColors.textPrimary,
        ),
        bodySmall: AppTextStyles.withColor(
          AppTextStyles.bodySmall,
          AppColors.textSecondary,
        ),
        labelLarge: AppTextStyles.withColor(
          AppTextStyles.labelLarge,
          AppColors.textPrimary,
        ),
        labelMedium: AppTextStyles.withColor(
          AppTextStyles.labelMedium,
          AppColors.textSecondary,
        ),
        labelSmall: AppTextStyles.withColor(
          AppTextStyles.labelSmall,
          AppColors.textSecondary,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 2,
        shadowColor: AppColors.shadowLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          textStyle: AppTextStyles.buttonMedium,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.buttonMedium,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.buttonMedium,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: AppTextStyles.withColor(
          AppTextStyles.inputHint,
          AppColors.textTertiary,
        ),
        labelStyle: AppTextStyles.withColor(
          AppTextStyles.inputLabel,
          AppColors.textSecondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Navigation Bar Theme (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTextStyles.withColor(
              AppTextStyles.navigationLabel,
              AppColors.primary,
            );
          }
          return AppTextStyles.withColor(
            AppTextStyles.navigationLabel,
            AppColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary);
          }
          return const IconThemeData(color: AppColors.textSecondary);
        }),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.onSecondary,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryContainer;
          }
          return AppColors.dividerColor;
        }),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.dividerColor,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerColor,
        thickness: 1,
        space: 1,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariant,
        selectedColor: AppColors.primaryContainer,
        disabledColor: AppColors.dividerColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: AppTextStyles.labelSmall,
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkOnSurface,
        surfaceContainerHighest: AppColors.darkSurfaceVariant,
        onSurfaceVariant: AppColors.darkTextSecondary,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.withColor(
          AppTextStyles.titleLarge,
          AppColors.darkTextPrimary,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.darkTextPrimary,
          size: 24,
        ),
      ),

      // Text Theme (Dark)
      textTheme: TextTheme(
        displayLarge: AppTextStyles.withColor(
          AppTextStyles.displayLarge,
          AppColors.darkTextPrimary,
        ),
        displayMedium: AppTextStyles.withColor(
          AppTextStyles.displayMedium,
          AppColors.darkTextPrimary,
        ),
        displaySmall: AppTextStyles.withColor(
          AppTextStyles.displaySmall,
          AppColors.darkTextPrimary,
        ),
        headlineLarge: AppTextStyles.withColor(
          AppTextStyles.headlineLarge,
          AppColors.darkTextPrimary,
        ),
        headlineMedium: AppTextStyles.withColor(
          AppTextStyles.headlineMedium,
          AppColors.darkTextPrimary,
        ),
        headlineSmall: AppTextStyles.withColor(
          AppTextStyles.headlineSmall,
          AppColors.darkTextPrimary,
        ),
        titleLarge: AppTextStyles.withColor(
          AppTextStyles.titleLarge,
          AppColors.darkTextPrimary,
        ),
        titleMedium: AppTextStyles.withColor(
          AppTextStyles.titleMedium,
          AppColors.darkTextPrimary,
        ),
        titleSmall: AppTextStyles.withColor(
          AppTextStyles.titleSmall,
          AppColors.darkTextPrimary,
        ),
        bodyLarge: AppTextStyles.withColor(
          AppTextStyles.bodyLarge,
          AppColors.darkTextPrimary,
        ),
        bodyMedium: AppTextStyles.withColor(
          AppTextStyles.bodyMedium,
          AppColors.darkTextPrimary,
        ),
        bodySmall: AppTextStyles.withColor(
          AppTextStyles.bodySmall,
          AppColors.darkTextSecondary,
        ),
        labelLarge: AppTextStyles.withColor(
          AppTextStyles.labelLarge,
          AppColors.darkTextPrimary,
        ),
        labelMedium: AppTextStyles.withColor(
          AppTextStyles.labelMedium,
          AppColors.darkTextSecondary,
        ),
        labelSmall: AppTextStyles.withColor(
          AppTextStyles.labelSmall,
          AppColors.darkTextSecondary,
        ),
      ),

      // Card Theme (Dark)
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 4,
        shadowColor: AppColors.shadowDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Other theme properties remain similar but with dark colors...
    );
  }

  // Helper method to get current theme colors
  static AppThemeExtension of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return AppThemeExtension(isDark: brightness == Brightness.dark);
  }
}

// Extension class for additional theme properties
class AppThemeExtension {
  final bool isDark;

  const AppThemeExtension({required this.isDark});

  // Prayer time specific colors
  Color get prayerCardBackground =>
      isDark ? AppColors.darkSurface : AppColors.prayerInactiveCard;

  Color get prayerActiveBackground =>
      isDark ? AppColors.primaryContainer : AppColors.prayerActiveCard;

  Color get qiblaBackground =>
      isDark ? AppColors.darkSurfaceVariant : AppColors.qiblaBackground;

  // Text colors based on theme
  Color get primaryText =>
      isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

  Color get secondaryText =>
      isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

  // Shadow colors
  Color get cardShadow => isDark ? AppColors.shadowDark : AppColors.shadowLight;
}
