import 'package:flutter/material.dart';

/// Utility class for responsive design throughout the app
class ResponsiveUtils {
  final BuildContext context;
  late final MediaQueryData _mediaQuery;
  late final double _screenWidth;
  late final double _screenHeight;

  ResponsiveUtils(this.context) {
    _mediaQuery = MediaQuery.of(context);
    _screenWidth = _mediaQuery.size.width;
    _screenHeight = _mediaQuery.size.height;
  }

  // Screen dimensions
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;

  // Text scaling
  double get textScaleFactor => _mediaQuery.textScaler.scale(1.0);

  // Padding
  EdgeInsets get viewPadding => _mediaQuery.viewPadding;
  EdgeInsets get viewInsets => _mediaQuery.viewInsets;

  // Device type checks
  bool get isMobile => _screenWidth < 600;
  bool get isTablet => _screenWidth >= 600 && _screenWidth < 900;
  bool get isDesktop => _screenWidth >= 900;

  // Responsive width
  double wp(double percentage) => _screenWidth * percentage / 100;

  // Responsive height
  double hp(double percentage) => _screenHeight * percentage / 100;

  // Responsive font size
  double sp(double size) {
    // Base size for 375px width (iPhone SE/8)
    const baseWidth = 375.0;
    final scale = _screenWidth / baseWidth;
    return size * scale;
  }

  // Responsive spacing
  double spacing(double size) {
    return wp(size);
  }

  // Responsive padding
  EdgeInsets paddingAll(double size) {
    return EdgeInsets.all(wp(size));
  }

  EdgeInsets paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return EdgeInsets.symmetric(
      horizontal: wp(horizontal),
      vertical: hp(vertical),
    );
  }

  EdgeInsets paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: wp(left),
      top: hp(top),
      right: wp(right),
      bottom: hp(bottom),
    );
  }

  // Responsive border radius
  BorderRadius borderRadius(double radius) {
    return BorderRadius.circular(wp(radius));
  }

  // Responsive icon size
  double iconSize(double size) {
    return wp(size);
  }

  // Get responsive text style
  TextStyle getTextStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontSize: sp(fontSize),
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Responsive container size
  Size containerSize(
      {required double widthPercentage, required double heightPercentage}) {
    return Size(wp(widthPercentage), hp(heightPercentage));
  }

  // Check orientation
  bool get isPortrait => _mediaQuery.orientation == Orientation.portrait;
  bool get isLandscape => _mediaQuery.orientation == Orientation.landscape;

  // Safe area
  EdgeInsets get safeAreaPadding => _mediaQuery.padding;

  // Keyboard height
  double get keyboardHeight => _mediaQuery.viewInsets.bottom;
  bool get isKeyboardVisible => keyboardHeight > 0;
}

/// Extension to make ResponsiveUtils easier to use
extension ResponsiveContext on BuildContext {
  ResponsiveUtils get responsive => ResponsiveUtils(this);
}
