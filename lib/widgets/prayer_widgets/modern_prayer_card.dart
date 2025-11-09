import 'package:flutter/material.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class ModernPrayerCard extends StatelessWidget {
  final String prayerName;
  final String prayerTime;
  final bool isActive;
  final bool isNextPrayer;
  final bool isBeepEnabled;
  final VoidCallback? onToggleBeep;
  final String? countdown;

  const ModernPrayerCard({
    super.key,
    required this.prayerName,
    required this.prayerTime,
    this.isActive = false,
    this.isNextPrayer = false,
    this.isBeepEnabled = false,
    this.onToggleBeep,
    this.countdown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.prayerActiveCard
            : Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.dividerColor,
          width: isActive ? 2 : 1,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          onTap: () {
            // Could show prayer details or other actions
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                // Prayer Icon
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary
                        : AppColors.primaryContainer,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.borderRadiusSm),
                  ),
                  child: Icon(
                    _getPrayerIcon(prayerName),
                    color: isActive ? Colors.white : AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Prayer Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            prayerName,
                            style: AppTextStyles.withColor(
                              AppTextStyles.titleMedium,
                              isActive
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                          if (isNextPrayer) ...[
                            const SizedBox(width: AppSpacing.xs),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(
                                    AppSpacing.borderRadiusXs),
                              ),
                              child: Text(
                                'Next',
                                style: AppTextStyles.withColor(
                                  AppTextStyles.labelSmall,
                                  AppColors.onSecondary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (countdown != null && isNextPrayer) ...[
                        const SizedBox(height: 4),
                        Text(
                          countdown!,
                          style: AppTextStyles.withColor(
                            AppTextStyles.bodySmall,
                            AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Prayer Time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      prayerTime,
                      style: AppTextStyles.withColor(
                        AppTextStyles.prayerTimeNumber.copyWith(fontSize: 24),
                        isActive ? AppColors.primary : AppColors.textPrimary,
                      ),
                    ),
                    if (isActive)
                      Text(
                        'Now',
                        style: AppTextStyles.withColor(
                          AppTextStyles.labelSmall,
                          AppColors.success,
                        ),
                      ),
                  ],
                ),

                // Notification Toggle
                if (onToggleBeep != null) ...[
                  const SizedBox(width: AppSpacing.sm),
                  IconButton(
                    icon: Icon(
                      isBeepEnabled
                          ? Icons.notifications_active
                          : Icons.notifications_off_outlined,
                      color: isBeepEnabled
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      size: 24,
                    ),
                    onPressed: onToggleBeep,
                    tooltip: isBeepEnabled
                        ? 'Disable notification'
                        : 'Enable notification',
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getPrayerIcon(String prayerName) {
    switch (prayerName.toLowerCase()) {
      case 'fajr':
        return FlutterIslamicIcons.lantern;
      case 'sunrise':
        return Icons.wb_twilight_outlined;
      case 'dhuhr':
        return Icons.wb_sunny_outlined;
      case 'asr':
        return Icons.wb_twilight;
      case 'maghrib':
        return FlutterIslamicIcons.crescentMoon;
      case 'isha':
        return FlutterIslamicIcons.mosque;
      default:
        return FlutterIslamicIcons.prayingPerson;
    }
  }
}
