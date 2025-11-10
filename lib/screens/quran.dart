import 'package:flutter/material.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:gicc/screens/surah_detail_screen.dart';
import 'package:gicc/screens/surah_list_screen.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF5F7FA),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card
                Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2C6B6D),
                        Color(0xFF4A8C8E),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        size: 64,
                        color: Colors.white,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'القرآن الكريم',
                        style: AppTextStyles.displaySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'The Holy Quran',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Browse All Surahs Button
                _buildBrowseAllButton(context),

                const SizedBox(height: AppSpacing.xl),

                // Popular Surahs Section
                Text(
                  'Popular Surahs',
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                _buildSurahCard(
                  context,
                  number: '1',
                  arabicName: 'الفاتحة',
                  englishName: 'Al-Fatiha',
                  meaning: 'The Opening',
                  verses: '7 verses',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SurahDetailScreen(
                        surahNumber: 1,
                        surahName: 'Al-Fatiha',
                        surahNameArabic: 'الفاتحة',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                _buildSurahCard(
                  context,
                  number: '36',
                  arabicName: 'يس',
                  englishName: 'Ya-Sin',
                  meaning: 'Ya-Sin',
                  verses: '83 verses',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SurahDetailScreen(
                        surahNumber: 36,
                        surahName: 'Ya-Sin',
                        surahNameArabic: 'يس',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                _buildSurahCard(
                  context,
                  number: '55',
                  arabicName: 'الرحمن',
                  englishName: 'Ar-Rahman',
                  meaning: 'The Most Merciful',
                  verses: '78 verses',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SurahDetailScreen(
                        surahNumber: 55,
                        surahName: 'Ar-Rahman',
                        surahNameArabic: 'الرحمن',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                _buildSurahCard(
                  context,
                  number: '67',
                  arabicName: 'الملك',
                  englishName: 'Al-Mulk',
                  meaning: 'The Sovereignty',
                  verses: '30 verses',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SurahDetailScreen(
                        surahNumber: 67,
                        surahName: 'Al-Mulk',
                        surahNameArabic: 'الملك',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrowseAllButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SurahListScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF2C6B6D),
                Color(0xFF4A8C8E),
              ],
            ),
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.list_rounded,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Browse All 114 Surahs',
                style: AppTextStyles.titleMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSurahCard(
    BuildContext context, {
    required String number,
    required String arabicName,
    required String englishName,
    required String meaning,
    required String verses,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(
              color: AppColors.dividerColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Surah Number
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Surah Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          englishName,
                          style: AppTextStyles.titleSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '($meaning)',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      verses,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Arabic Name
              Text(
                arabicName,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
