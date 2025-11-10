import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:gicc/providers/prayertimes_provider.dart';
import 'package:provider/provider.dart';

class ModernBottomNavigation extends StatelessWidget {
  const ModernBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<PrayerTimesProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C2128) : Colors.white,
            border: Border(
              top: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : const Color(0xFFE5E7EB),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    _buildNavItems(provider.bottomsheetIndex, provider, isDark),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildNavItems(
      int selectedIndex, PrayerTimesProvider provider, bool isDark) {
    final items = [
      _NavItem(
        icon: FlutterIslamicIcons.prayingPerson,
        label: 'Prayer',
        index: 0,
      ),
      _NavItem(
        icon: FlutterIslamicIcons.qibla,
        label: 'Qibla',
        index: 1,
      ),
      _NavItem(
        icon: FlutterIslamicIcons.community,
        label: 'Events',
        index: 2,
      ),
      _NavItem(
        icon: FlutterIslamicIcons.quran2,
        label: 'Quran',
        index: 3,
      ),
      _NavItem(
        icon: FlutterIslamicIcons.muslim,
        label: 'Profile',
        index: 4,
      ),
    ];

    return items.map((item) {
      final isSelected = selectedIndex == item.index;
      return Expanded(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => provider.selectedBottomSheetIndex(item.index),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [
                                Color(0xFF2C6B6D),
                                Color(0xFF4A8C8E),
                              ],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      item.icon,
                      size: 24,
                      color: isSelected
                          ? Colors.white
                          : isDark
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? (isDark
                              ? AppColors.primaryLight
                              : AppColors.primary)
                          : (isDark
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF6B7280)),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final int index;

  _NavItem({
    required this.icon,
    required this.label,
    required this.index,
  });
}
