/// App spacing constants following 8px grid system
class AppSpacing {
  AppSpacing._();

  // Base unit (8px)
  static const double base = 8.0;

  // Spacing values
  static const double xs = base * 0.5; // 4px
  static const double sm = base * 1; // 8px
  static const double md = base * 2; // 16px
  static const double lg = base * 3; // 24px
  static const double xl = base * 4; // 32px
  static const double xxl = base * 6; // 48px
  static const double xxxl = base * 8; // 64px

  // Common margin values
  static const double marginXs = xs;
  static const double marginSm = sm;
  static const double marginMd = md;
  static const double marginLg = lg;
  static const double marginXl = xl;

  // Common padding values
  static const double paddingXs = xs;
  static const double paddingSm = sm;
  static const double paddingMd = md;
  static const double paddingLg = lg;
  static const double paddingXl = xl;

  // Screen margins
  static const double screenHorizontal = md; // 16px
  static const double screenVertical = md; // 16px

  // Card spacing
  static const double cardPadding = md; // 16px
  static const double cardMargin = sm; // 8px
  static const double cardSpacing = md; // 16px between cards

  // Button spacing
  static const double buttonPaddingVertical = 12.0;
  static const double buttonPaddingHorizontal = lg; // 24px
  static const double buttonSpacing = md; // 16px between buttons

  // List spacing
  static const double listItemSpacing = sm; // 8px
  static const double listSectionSpacing = lg; // 24px

  // Prayer times specific
  static const double prayerCardPadding = md; // 16px
  static const double prayerCardSpacing = sm; // 8px
  static const double prayerTimeSpacing = xs; // 4px

  // Navigation spacing
  static const double navigationPadding = sm; // 8px
  static const double appBarPadding = md; // 16px

  // Form spacing
  static const double formFieldSpacing = md; // 16px
  static const double formSectionSpacing = xl; // 32px

  // Icon spacing
  static const double iconSpacing = sm; // 8px
  static const double iconPadding = xs; // 4px

  // Border radius values
  static const double borderRadiusXs = 4.0;
  static const double borderRadiusSm = 8.0;
  static const double borderRadiusMd = 12.0;
  static const double borderRadiusLg = 16.0;
  static const double borderRadiusXl = 24.0;
  static const double borderRadiusRound = 50.0;

  // Common border radius
  static const double cardRadius = borderRadiusLg; // 16px
  static const double buttonRadius = borderRadiusMd; // 12px
  static const double inputRadius = borderRadiusMd; // 12px
  static const double chipRadius = borderRadiusSm; // 8px
}

/// App elevation constants
class AppElevation {
  AppElevation._();

  static const double none = 0.0;
  static const double minimal = 1.0;
  static const double low = 2.0;
  static const double medium = 4.0;
  static const double high = 8.0;
  static const double maximum = 16.0;

  // Component specific elevations
  static const double card = low; // 2dp
  static const double button = low; // 2dp
  static const double fab = medium; // 6dp
  static const double appBar = none; // 0dp (Material 3 style)
  static const double bottomNavigation = medium; // 8dp
  static const double modal = maximum; // 16dp
}

/// App animation durations
class AppDuration {
  AppDuration._();

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  // Specific animation durations
  static const Duration pageTransition = medium;
  static const Duration buttonPress = fast;
  static const Duration cardExpansion = medium;
  static const Duration prayerTimeUpdate = slow;
  static const Duration qiblaRotation = medium;
  static const Duration loading = medium;
}
