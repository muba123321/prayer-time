import 'package:flutter/material.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:gicc/providers/prayertimes_provider.dart';
import 'package:provider/provider.dart';

class QuickActionFab extends StatelessWidget {
  const QuickActionFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerTimesProvider>(
      builder: (context, provider, child) {
        return FloatingActionButton.extended(
          onPressed: () {
            _showQuickActions(context);
          },
          icon: const Icon(Icons.access_time),
          label: Text(
            'Next Prayer',
            style: AppTextStyles.buttonMedium,
          ),
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.onSecondary,
        );
      },
    );
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.md),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Quick Actions',
              style: AppTextStyles.withColor(
                AppTextStyles.titleLarge,
                AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                children: [
                  _buildQuickActionTile(
                    context,
                    icon: Icons.access_time,
                    title: 'Next Prayer Time',
                    subtitle: 'View upcoming prayer',
                    onTap: () {
                      Navigator.pop(context);
                      context
                          .read<PrayerTimesProvider>()
                          .selectedBottomSheetIndex(0);
                    },
                  ),
                  _buildQuickActionTile(
                    context,
                    icon: Icons.explore,
                    title: 'Qibla Direction',
                    subtitle: 'Find direction to Mecca',
                    onTap: () {
                      Navigator.pop(context);
                      context
                          .read<PrayerTimesProvider>()
                          .selectedBottomSheetIndex(1);
                    },
                  ),
                  _buildQuickActionTile(
                    context,
                    icon: Icons.event,
                    title: 'Community Events',
                    subtitle: 'Check upcoming events',
                    onTap: () {
                      Navigator.pop(context);
                      context
                          .read<PrayerTimesProvider>()
                          .selectedBottomSheetIndex(2);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusSm),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.withColor(
          AppTextStyles.titleMedium,
          AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.withColor(
          AppTextStyles.bodySmall,
          AppColors.textSecondary,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}
