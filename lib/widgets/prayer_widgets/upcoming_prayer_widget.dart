import 'package:flutter/material.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class UpcomingPrayerWidget extends StatelessWidget {
  final String prayerName;
  final String prayerTime;
  final String countdown;

  const UpcomingPrayerWidget({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    required this.countdown,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF2C3E50), // Elegant dark slate
                  const Color(0xFF34495E), // Lighter slate
                ]
              : [
                  AppColors.primary, // Muted teal
                  AppColors.primaryLight, // Lighter teal
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background decorative pattern
          Positioned(
            right: -30,
            top: -30,
            child: Icon(
              FlutterIslamicIcons.mosque,
              size: 140,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),

          Positioned(
            left: -20,
            bottom: -20,
            child: Icon(
              FlutterIslamicIcons.quran,
              size: 100,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon and label
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.borderRadiusXs),
                      ),
                      child: const Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'UPCOMING PRAYER',
                      style: AppTextStyles.withColor(
                        AppTextStyles.labelMedium.copyWith(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                        Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Prayer name - prominent display
                Text(
                  prayerName,
                  style: AppTextStyles.withColor(
                    AppTextStyles.headlineLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),

                // Prayer time with icon
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      prayerTime,
                      style: AppTextStyles.withColor(
                        AppTextStyles.titleLarge.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                        Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Countdown in elegant card
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.borderRadiusMd),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        color: Colors.white.withValues(alpha: 0.9),
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        countdown,
                        style: AppTextStyles.withColor(
                          AppTextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
