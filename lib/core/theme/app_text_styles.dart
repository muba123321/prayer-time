import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  // Base font families
  static const String primaryFontFamily = 'Poppins';
  static const String arabicFontFamily = 'Amiri';
  static const String displayFontFamily = 'Inter';

  // Font weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // Display styles for headers and large text
  static TextStyle get displayLarge => GoogleFonts.inter(
        fontSize: 57,
        fontWeight: regular,
        letterSpacing: -0.25,
        height: 1.12,
      );

  static TextStyle get displayMedium => GoogleFonts.inter(
        fontSize: 45,
        fontWeight: regular,
        letterSpacing: 0,
        height: 1.16,
      );

  static TextStyle get displaySmall => GoogleFonts.inter(
        fontSize: 36,
        fontWeight: regular,
        letterSpacing: 0,
        height: 1.22,
      );

  // Headline styles for section headers
  static TextStyle get headlineLarge => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: semiBold,
        letterSpacing: 0,
        height: 1.25,
      );

  static TextStyle get headlineMedium => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: semiBold,
        letterSpacing: 0,
        height: 1.29,
      );

  static TextStyle get headlineSmall => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: semiBold,
        letterSpacing: 0,
        height: 1.33,
      );

  // Title styles for card headers and important text
  static TextStyle get titleLarge => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: semiBold,
        letterSpacing: 0,
        height: 1.27,
      );

  static TextStyle get titleMedium => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: medium,
        letterSpacing: 0.15,
        height: 1.5,
      );

  static TextStyle get titleSmall => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: medium,
        letterSpacing: 0.1,
        height: 1.43,
      );

  // Label styles for buttons and form labels
  static TextStyle get labelLarge => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: medium,
        letterSpacing: 0.1,
        height: 1.43,
      );

  static TextStyle get labelMedium => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: medium,
        letterSpacing: 0.5,
        height: 1.33,
      );

  static TextStyle get labelSmall => GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: medium,
        letterSpacing: 0.5,
        height: 1.45,
      );

  // Body styles for regular content
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: regular,
        letterSpacing: 0.5,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: regular,
        letterSpacing: 0.25,
        height: 1.43,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: regular,
        letterSpacing: 0.4,
        height: 1.33,
      );

  // Arabic text styles for Quranic content
  static TextStyle get arabicLarge => GoogleFonts.amiri(
        fontSize: 24,
        fontWeight: regular,
        height: 2.0,
        letterSpacing: 0,
      );

  static TextStyle get arabicMedium => GoogleFonts.amiri(
        fontSize: 20,
        fontWeight: regular,
        height: 1.8,
        letterSpacing: 0,
      );

  static TextStyle get arabicSmall => GoogleFonts.amiri(
        fontSize: 18,
        fontWeight: regular,
        height: 1.6,
        letterSpacing: 0,
      );

  // Prayer time specific styles
  static TextStyle get prayerTimeNumber => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: bold,
        letterSpacing: 0,
        height: 1.2,
      );

  static TextStyle get prayerTimeName => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: semiBold,
        letterSpacing: 0,
        height: 1.2,
      );

  static TextStyle get prayerTimeSubtitle => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: regular,
        letterSpacing: 0.25,
        height: 1.4,
      );

  static TextStyle get countdownTime => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: medium,
        letterSpacing: 0.5,
        height: 1.3,
      );

  // Card and component styles
  static TextStyle get cardTitle => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: semiBold,
        letterSpacing: 0,
        height: 1.3,
      );

  static TextStyle get cardSubtitle => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: regular,
        letterSpacing: 0.25,
        height: 1.4,
      );

  static TextStyle get cardBody => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: regular,
        letterSpacing: 0.25,
        height: 1.5,
      );

  // Button styles
  static TextStyle get buttonLarge => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: semiBold,
        letterSpacing: 0.1,
        height: 1.25,
      );

  static TextStyle get buttonMedium => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: semiBold,
        letterSpacing: 0.1,
        height: 1.25,
      );

  static TextStyle get buttonSmall => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: semiBold,
        letterSpacing: 0.1,
        height: 1.25,
      );

  // Navigation and tab styles
  static TextStyle get navigationLabel => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: medium,
        letterSpacing: 0.5,
        height: 1.3,
      );

  static TextStyle get tabLabel => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: medium,
        letterSpacing: 0.1,
        height: 1.25,
      );

  // Form field styles
  static TextStyle get inputText => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: regular,
        letterSpacing: 0.5,
        height: 1.5,
      );

  static TextStyle get inputLabel => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: medium,
        letterSpacing: 0.4,
        height: 1.33,
      );

  static TextStyle get inputHint => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: regular,
        letterSpacing: 0.5,
        height: 1.5,
      );

  static TextStyle get inputError => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: regular,
        letterSpacing: 0.4,
        height: 1.33,
      );

  // Caption and helper text
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: regular,
        letterSpacing: 0.4,
        height: 1.33,
      );

  static TextStyle get overline => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: medium,
        letterSpacing: 1.5,
        height: 1.6,
      );

  // Special Islamic app styles
  static TextStyle get bismillah => GoogleFonts.amiri(
        fontSize: 28,
        fontWeight: bold,
        height: 2.0,
        letterSpacing: 0,
      );

  static TextStyle get qiblaDirection => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: bold,
        letterSpacing: 0,
        height: 1.2,
      );

  static TextStyle get prayerNotification => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: semiBold,
        letterSpacing: 0,
        height: 1.3,
      );

  // Helper method to apply color to any text style
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  // Helper method to apply custom font size
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  // Helper method for responsive text sizing
  static double responsiveSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return baseSize * 1.1; // Slightly larger on tablets
    }
    return baseSize;
  }
}
