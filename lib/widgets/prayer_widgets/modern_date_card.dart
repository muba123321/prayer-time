import 'package:flutter/material.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:intl/intl.dart';

class ModernDateCard extends StatelessWidget {
  final String gregorianDate;
  final String hijriDate;
  final bool isToday;

  const ModernDateCard({
    super.key,
    required this.gregorianDate,
    required this.hijriDate,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    // Parse the date to get day name
    final dateParts = gregorianDate.split('-');
    final dateObj = DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[1]),
      int.parse(dateParts[0]),
    );
    final dayName = DateFormat('EEEE').format(dateObj);
    final monthYear = DateFormat('d MMMM yyyy').format(dateObj);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isToday
              ? [
                  AppColors.primary,
                  AppColors.primaryContainer,
                ]
              : [
                  Theme.of(context).cardTheme.color ?? Colors.white,
                  Theme.of(context).cardTheme.color ?? Colors.white,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
        boxShadow: [
          BoxShadow(
            color: isToday
                ? AppColors.primary.withValues(alpha: 0.3)
                : AppColors.shadowLight,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today badge
            if (isToday)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.borderRadiusXs),
                ),
                child: Text(
                  'TODAY',
                  style: AppTextStyles.withColor(
                    AppTextStyles.labelSmall,
                    Colors.white,
                  ),
                ),
              ),
            if (isToday) const SizedBox(height: AppSpacing.sm),

            // Day name
            Text(
              dayName,
              style: AppTextStyles.withColor(
                AppTextStyles.headlineMedium,
                isToday ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),

            // Gregorian date
            Text(
              monthYear,
              style: AppTextStyles.withColor(
                AppTextStyles.bodyMedium,
                isToday
                    ? Colors.white.withValues(alpha: 0.9)
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Divider
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isToday
                      ? [
                          Colors.white.withValues(alpha: 0.3),
                          Colors.white.withValues(alpha: 0.1),
                        ]
                      : [
                          AppColors.dividerColor,
                          AppColors.dividerColor.withValues(alpha: 0.1),
                        ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Hijri date
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                  color: isToday
                      ? Colors.white.withValues(alpha: 0.9)
                      : AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Islamic Date',
                  style: AppTextStyles.withColor(
                    AppTextStyles.labelMedium,
                    isToday
                        ? Colors.white.withValues(alpha: 0.9)
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              hijriDate,
              style: AppTextStyles.withColor(
                AppTextStyles.titleMedium,
                isToday ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
