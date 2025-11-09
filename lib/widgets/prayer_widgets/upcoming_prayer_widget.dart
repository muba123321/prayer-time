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
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondary,
            AppColors.secondary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              FlutterIslamicIcons.mosque,
              size: 120,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.borderRadiusXs),
                      ),
                      child: const Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'NEXT PRAYER',
                      style: AppTextStyles.withColor(
                        AppTextStyles.labelMedium,
                        Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Prayer name
                Text(
                  prayerName,
                  style: AppTextStyles.withColor(
                    AppTextStyles.headlineLarge,
                    Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),

                // Prayer time
                Text(
                  prayerTime,
                  style: AppTextStyles.withColor(
                    AppTextStyles.titleLarge.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Countdown
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.borderRadiusMd),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        countdown,
                        style: AppTextStyles.withColor(
                          AppTextStyles.titleMedium,
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
