import 'package:flutter/material.dart';
import 'package:gicc/providers/onboarding_provider.dart';
import 'package:gicc/pages/homepage.dart';
import 'package:gicc/widgets/onboarding_widgets/onboarding_card.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gicc/core/theme/app_colors.dart';
import 'package:gicc/utils/responsive_utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  void _finishOnboarding(BuildContext context) {
    context.read<OnboardingProvider>().finishOnboarding().then((value) {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Consumer<OnboardingProvider>(builder: (context, notifier, __) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryLight.withOpacity(0.1),
                Colors.white,
                AppColors.accent.withOpacity(0.05),
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Skip button
                Positioned(
                  top: responsive.hp(2),
                  right: responsive.wp(4),
                  child: Selector<OnboardingProvider, int>(
                    selector: (context, provider) => provider.currentIndex,
                    builder: (context, current, _) {
                      if (current == 2) return const SizedBox.shrink();

                      return TextButton.icon(
                        onPressed: () => _finishOnboarding(context),
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          padding: responsive.paddingSymmetric(
                              horizontal: 4, vertical: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: responsive.borderRadius(12),
                            side: BorderSide(
                              color: AppColors.primary.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                        ),
                        icon: Icon(
                          Icons.skip_next_rounded,
                          color: AppColors.primary,
                          size: responsive.hp(2.5),
                        ),
                        label: Text(
                          'Skip',
                          style: GoogleFonts.poppins(
                            fontSize: responsive.sp(14),
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Selector<OnboardingProvider, int>(
                  selector: (context, provider) => provider.currentIndex,
                  builder: (context, current, _) {
                    return Column(
                      children: [
                        Expanded(
                          child: Swiper(
                            controller: notifier.swiperController,
                            itemHeight: double.infinity,
                            itemWidth: double.infinity,
                            indicatorLayout: PageIndicatorLayout.WARM,
                            layout: SwiperLayout.DEFAULT,
                            onIndexChanged: (value) {
                              notifier.selectedIndex(value);
                              notifier.swiperController.index = value;
                            },
                            index: notifier.currentIndex,
                            curve: Curves.easeInOutCubic,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return OnboardingCard(index: index);
                            },
                            pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                color: AppColors.primary.withOpacity(0.3),
                                activeColor: AppColors.primary,
                                size: responsive.hp(1.2),
                                activeSize: responsive.hp(1.5),
                                space: responsive.wp(2),
                              ),
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.all(responsive.hp(1.5)),
                            ),
                            loop: false,
                          ),
                        ),

                        // Navigation buttons
                        Padding(
                          padding: responsive.paddingSymmetric(
                              horizontal: 5, vertical: 3),
                          child: Row(
                            children: [
                              // Back button
                              if (current != 0)
                                Expanded(
                                  child: SizedBox(
                                    height: responsive.hp(6.5),
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          width: 2,
                                          color: AppColors.primary,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              responsive.borderRadius(16),
                                        ),
                                      ),
                                      onPressed: () {
                                        notifier.swiperController.previous();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_rounded,
                                        color: AppColors.primary,
                                        size: responsive.hp(2.5),
                                      ),
                                      label: Text(
                                        'Back',
                                        style: GoogleFonts.poppins(
                                          fontSize: responsive.sp(16),
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              if (current != 0)
                                SizedBox(width: responsive.wp(3)),

                              // Next/Done button
                              Expanded(
                                child: SizedBox(
                                  height: responsive.hp(6.5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          AppColors.primary,
                                          AppColors.primaryLight,
                                        ],
                                      ),
                                      borderRadius: responsive.borderRadius(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary
                                              .withOpacity(0.3),
                                          offset: const Offset(0, 4),
                                          blurRadius: 12,
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              responsive.borderRadius(16),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (notifier.swiperController.index <
                                            2) {
                                          notifier.swiperController.next();
                                        } else {
                                          _finishOnboarding(context);
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            current == 2
                                                ? 'Get Started'
                                                : 'Next',
                                            style: GoogleFonts.poppins(
                                              fontSize: responsive.sp(16),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(width: responsive.wp(2)),
                                          Icon(
                                            current == 2
                                                ? Icons.check_circle_rounded
                                                : Icons.arrow_forward_rounded,
                                            color: Colors.white,
                                            size: responsive.hp(2.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
