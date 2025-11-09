import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors - Islamic Green Theme
  static const Color primary = Color(0xFF0D7E3D); // Islamic Green
  static const Color primaryContainer = Color(0xFF4CAF50);
  static const Color onPrimary = Colors.white;
  static const Color onPrimaryContainer = Color(0xFF002106);

  // Secondary Colors - Gold/Amber Theme
  static const Color secondary = Color(0xFFFFD700); // Gold
  static const Color secondaryContainer = Color(0xFFFFE082);
  static const Color onSecondary = Color(0xFF1A1A1A);
  static const Color onSecondaryContainer = Color(0xFF332900);

  // Surface Colors
  static const Color surface = Color(0xFFFAFAFA);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color onSurface = Color(0xFF1A1A1A);
  static const Color onSurfaceVariant = Color(0xFF6B7280);

  // Background Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color onBackground = Color(0xFF1A1A1A);

  // Card and Component Colors
  static const Color cardBackground = Colors.white;
  static const Color dividerColor = Color(0xFFE0E0E0);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);

  // Prayer Time Specific Colors
  static const Color prayerActiveCard = Color(0xFFE8F5E8);
  static const Color prayerInactiveCard = Colors.white;
  static const Color prayerTimeBorder = Color(0xFF0D7E3D);
  static const Color prayerProgressActive = Color(0xFF4CAF50);
  static const Color prayerProgressInactive = Color(0xFFE0E0E0);

  // Qibla Colors
  static const Color qiblaCompass = Color(0xFF0D7E3D);
  static const Color qiblaCompassAccent = Color(0xFFFFD700);
  static const Color qiblaBackground = Color(0xFFF0F8F0);

  // Event Colors
  static const Color eventPrimary = Color(0xFF1976D2);
  static const Color eventSecondary = Color(0xFF9C27B0);
  static const Color eventSuccess = Color(0xFF388E3C);
  static const Color eventWarning = Color(0xFFFF9800);

  // Error and Status Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Colors.white;
  static const Color onErrorContainer = Color(0xFF410002);

  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF1976D2);

  // Shadow Colors
  static const Color shadowLight = Color(0x0F000000);
  static const Color shadowMedium = Color(0x1F000000);
  static const Color shadowDark = Color(0x3F000000);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F1419);
  static const Color darkSurface = Color(0xFF1C2128);
  static const Color darkSurfaceVariant = Color(0xFF262C36);
  static const Color darkOnBackground = Color(0xFFE6EDF3);
  static const Color darkOnSurface = Color(0xFFE6EDF3);
  static const Color darkTextPrimary = Color(0xFFE6EDF3);
  static const Color darkTextSecondary = Color(0xFFB1BAC4);

  // Islamic Pattern Colors
  static const Color patternPrimary = Color(0xFF0D7E3D);
  static const Color patternSecondary = Color(0xFFFFD700);
  static const Color patternTertiary = Color(0xFF2E7D32);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF0D7E3D),
    Color(0xFF2E7D32),
  ];

  static const List<Color> secondaryGradient = [
    Color(0xFFFFD700),
    Color(0xFFFFE082),
  ];

  static const List<Color> backgroundGradient = [
    Color(0xFFF8F9FA),
    Color(0xFFFFFFFF),
  ];

  // Helper method to get color with opacity
  static Color withAlpha(Color color, double alpha) {
    return color.withValues(alpha: alpha);
  }

  // Helper methods for common color combinations
  static Color get prayerCardShadow => withAlpha(primary, 0.1);
  static Color get qiblaShadow => withAlpha(qiblaCompass, 0.2);
  static Color get eventCardShadow => withAlpha(textPrimary, 0.1);
}
