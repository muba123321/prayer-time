import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors - Modern Teal/Sage Theme (subtle, sophisticated)
  static const Color primary = Color(0xFF2C6B6D); // Muted teal-green
  static const Color primaryLight = Color(0xFF4A8C8E); // Lighter teal
  static const Color primaryDark = Color(0xFF1F4F51); // Darker teal
  static const Color primaryContainer = Color(0xFFD8ECED);
  static const Color onPrimary = Colors.white;
  static const Color onPrimaryContainer = Color(0xFF0A2526);

  // Secondary Colors - Warm Earth Tones (replacing harsh gold)
  static const Color secondary = Color(0xFF8B7355); // Warm taupe/brown
  static const Color secondaryLight = Color(0xFFA68B71); // Lighter brown
  static const Color secondaryContainer = Color(0xFFE8DDD3);
  static const Color onSecondary = Colors.white;
  static const Color onSecondaryContainer = Color(0xFF2B1F15);

  // Accent Colors - Soft Coral for highlights
  static const Color accent = Color(0xFFE07A5F); // Soft coral
  static const Color accentLight = Color(0xFFF2A490);

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
  static const Color prayerActiveCard =
      Color(0xFFF0F9F9); // Very light teal background
  static const Color prayerInactiveCard = Colors.white;
  static const Color prayerTimeBorder = Color(0xFF2C6B6D);
  static const Color prayerProgressActive = Color(0xFF4A8C8E);
  static const Color prayerProgressInactive = Color(0xFFE0E0E0);

  // Qibla Colors
  static const Color qiblaCompass = Color(0xFF2C6B6D);
  static const Color qiblaCompassAccent = Color(0xFF8B7355);
  static const Color qiblaBackground = Color(0xFFF0F5F5);

  // Event Colors - Modern palette
  static const Color eventPrimary = Color(0xFF5B8FA3); // Soft blue
  static const Color eventSecondary = Color(0xFF9A7AA0); // Soft purple
  static const Color eventSuccess = Color(0xFF6B9F88); // Soft green
  static const Color eventWarning = Color(0xFFE8B162); // Soft amber

  // Error and Status Colors
  static const Color error = Color(0xFFD94545);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Colors.white;
  static const Color onErrorContainer = Color(0xFF410002);

  static const Color success = Color(0xFF6B9F88);
  static const Color warning = Color(0xFFE8B162);
  static const Color info = Color(0xFF5B8FA3);

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
  static const Color patternPrimary = Color(0xFF2C6B6D);
  static const Color patternSecondary = Color(0xFF8B7355);
  static const Color patternTertiary = Color(0xFF4A8C8E);

  // Gradient Colors - Sophisticated gradients
  static const List<Color> primaryGradient = [
    Color(0xFF2C6B6D),
    Color(0xFF4A8C8E),
  ];

  static const List<Color> secondaryGradient = [
    Color(0xFF8B7355),
    Color(0xFFA68B71),
  ];

  static const List<Color> backgroundGradient = [
    Color(0xFFF8F9FA),
    Color(0xFFFFFFFF),
  ];

  // New modern gradients for cards
  static const List<Color> cardGradientCool = [
    Color(0xFFE8F3F3),
    Color(0xFFF5FAFA),
  ];

  static const List<Color> cardGradientWarm = [
    Color(0xFFF5F1ED),
    Color(0xFFFAF7F5),
  ];

  // Helper method to get color with opacity
  static Color withAlpha(Color color, double alpha) {
    return color.withValues(alpha: alpha);
  }

  // Helper methods for common color combinations
  static Color get prayerCardShadow => withAlpha(primary, 0.08);
  static Color get qiblaShadow => withAlpha(qiblaCompass, 0.12);
  static Color get eventCardShadow => withAlpha(textPrimary, 0.08);
}
