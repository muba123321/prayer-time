import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:gicc/providers/prayertimes_provider.dart';
import 'package:provider/provider.dart';

class ModernBottomNavigation extends StatelessWidget {
  const ModernBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<PrayerTimesProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: AppColors.withAlpha(AppColors.textPrimary, 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: NavigationBar(
              selectedIndex: provider.bottomsheetIndex,
              onDestinationSelected: (index) {
                provider.selectedBottomSheetIndex(index);
              },
              destinations: _buildNavDestinations(theme),
              height: 80,
              animationDuration: AppDuration.fast,
            ),
          ),
        );
      },
    );
  }

  List<NavigationDestination> _buildNavDestinations(ThemeData theme) {
    return [
      NavigationDestination(
        selectedIcon: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
          ),
          child: const Icon(
            FlutterIslamicIcons.prayingPerson,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        icon: const Icon(
          FlutterIslamicIcons.prayingPerson,
          size: 24,
        ),
        label: 'Prayer Times',
      ),
      NavigationDestination(
        selectedIcon: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
          ),
          child: const Icon(
            FlutterIslamicIcons.qibla,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        icon: const Icon(
          FlutterIslamicIcons.qibla,
          size: 24,
        ),
        label: 'Qibla',
      ),
      NavigationDestination(
        selectedIcon: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
          ),
          child: const Icon(
            FlutterIslamicIcons.community,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        icon: const Icon(
          FlutterIslamicIcons.community,
          size: 24,
        ),
        label: 'Events',
      ),
      NavigationDestination(
        selectedIcon: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
          ),
          child: const Icon(
            FlutterIslamicIcons.quran2,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        icon: const Icon(
          FlutterIslamicIcons.quran2,
          size: 24,
        ),
        label: 'Quran',
      ),
      NavigationDestination(
        selectedIcon: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
          ),
          child: const Icon(
            FlutterIslamicIcons.muslim,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        icon: const Icon(
          FlutterIslamicIcons.muslim,
          size: 24,
        ),
        label: 'Profile',
      ),
    ];
  }
}
