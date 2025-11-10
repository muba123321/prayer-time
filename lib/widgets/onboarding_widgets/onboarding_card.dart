import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gicc/utils/responsive_utils.dart';
import 'package:gicc/core/theme/app_colors.dart';

class OnboardingCard extends StatelessWidget {
  final int index;

  const OnboardingCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Container(
      padding: responsive.paddingSymmetric(horizontal: 6, vertical: 4),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (index == 0) ...[
              SizedBox(height: responsive.hp(6)),
              Container(
                padding: responsive.paddingAll(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/gaskia.png',
                  height: responsive.hp(16),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: responsive.hp(4)),
              Text(
                'Gaskia Islamic\nCommunity Center',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: responsive.sp(26),
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              SizedBox(height: responsive.hp(1)),
              Text(
                'Your Digital Masjid Companion',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: responsive.sp(15),
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: responsive.hp(5)),
              Padding(
                padding: responsive.paddingSymmetric(horizontal: 6),
                child: Column(
                  children: [
                    _buildSimpleFeature(responsive,
                        icon: Icons.access_time_rounded,
                        text: 'Accurate Prayer Times'),
                    SizedBox(height: responsive.hp(2.5)),
                    _buildSimpleFeature(responsive,
                        icon: Icons.explore_outlined,
                        text: 'Qibla Direction Finder'),
                    SizedBox(height: responsive.hp(2.5)),
                    _buildSimpleFeature(responsive,
                        icon: Icons.event_outlined,
                        text: 'Community Events & Updates'),
                    SizedBox(height: responsive.hp(2.5)),
                    _buildSimpleFeature(responsive,
                        icon: Icons.notifications_outlined,
                        text: 'Prayer Reminders'),
                  ],
                ),
              ),
              SizedBox(height: responsive.hp(4)),
            ] else if (index == 1) ...[
              SizedBox(height: responsive.hp(6)),
              Container(
                padding: responsive.paddingAll(20),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.access_time_rounded,
                    size: responsive.hp(10), color: AppColors.primary),
              ),
              SizedBox(height: responsive.hp(3)),
              Text(
                'Prayer Times',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: responsive.sp(26),
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: responsive.hp(4)),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/salat.png',
                      fit: BoxFit.contain, height: responsive.hp(20)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        const url =
                            'https://www.freepik.com/icon/islam_13801087#fromView=search&page=1&position=64&uuid=89e9a6e1-a534-46b1-a6ed-096bd7469a4b';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url),
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text('Icon by adriansyah',
                            style: GoogleFonts.poppins(
                                fontSize: 8,
                                color: AppColors.textSecondary,
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsive.hp(4)),
              Padding(
                padding: responsive.paddingSymmetric(horizontal: 6),
                child: Column(
                  children: [
                    _buildInfoBox(responsive,
                        icon: Icons.location_on_outlined,
                        text: 'Prayer times are set for this Masjid only',
                        color: AppColors.primary),
                    SizedBox(height: responsive.hp(2)),
                    _buildInfoBox(responsive,
                        icon: Icons.lock_outline,
                        text: 'Times stay the same regardless of your location',
                        color: AppColors.secondary),
                    SizedBox(height: responsive.hp(2)),
                    _buildInfoBox(responsive,
                        icon: Icons.notifications_active_outlined,
                        text: 'Enable notifications for prayer alerts',
                        color: AppColors.accent),
                  ],
                ),
              ),
              SizedBox(height: responsive.hp(4)),
            ] else if (index == 2) ...[
              SizedBox(height: responsive.hp(6)),
              Container(
                height: MediaQuery.of(context).size.height * 0.22,
                margin: responsive.paddingSymmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: responsive.borderRadius(20),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primary.withOpacity(0.15),
                        offset: const Offset(0, 4),
                        blurRadius: 16)
                  ],
                ),
                child: ClipRRect(
                  borderRadius: responsive.borderRadius(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset('assets/images/inside.jpg',
                          fit: BoxFit.cover),
                      Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.1)
                          ]))),
                    ],
                  ),
                ),
              ),
              SizedBox(height: responsive.hp(3)),
              Text('Everything You Need',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: responsive.sp(26),
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: responsive.hp(1)),
              Text('All in one place',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: responsive.sp(15),
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400)),
              SizedBox(height: responsive.hp(4)),
              Padding(
                padding: responsive.paddingSymmetric(horizontal: 4),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                          child: _buildFeatureBox(context, responsive,
                              icon: Icons.access_time_rounded,
                              text: 'Prayer\nTimes')),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Expanded(
                          child: _buildFeatureBox(context, responsive,
                              icon: Icons.explore_outlined,
                              text: 'Qibla\nDirection'))
                    ]),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(children: [
                      Expanded(
                          child: _buildFeatureBox(context, responsive,
                              icon: Icons.event_outlined,
                              text: 'Events &\nCalendar')),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Expanded(
                          child: _buildFeatureBox(context, responsive,
                              icon: Icons.notifications_rounded,
                              text: 'Prayer\nAlerts'))
                    ]),
                  ],
                ),
              ),
              SizedBox(height: responsive.hp(3)),
              GestureDetector(
                onTap: () async {
                  const url =
                      'https://www.freepik.com/free-ai-image/view-3d-islamic-mosque_133520409.htm';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalApplication);
                  }
                },
                child: Text('Image by Freepik',
                    style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.underline)),
              ),
              SizedBox(height: responsive.hp(2)),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleFeature(ResponsiveUtils responsive,
      {required IconData icon, required String text}) {
    return Row(children: [
      Container(
          padding: responsive.paddingAll(10),
          decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: responsive.borderRadius(12)),
          child: Icon(icon, size: responsive.hp(3), color: AppColors.primary)),
      SizedBox(width: responsive.wp(4)),
      Expanded(
          child: Text(text,
              style: GoogleFonts.poppins(
                  fontSize: responsive.sp(16),
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500)))
    ]);
  }

  Widget _buildInfoBox(ResponsiveUtils responsive,
      {required IconData icon, required String text, required Color color}) {
    return Container(
        padding: responsive.paddingAll(12),
        decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: responsive.borderRadius(12),
            border: Border.all(color: color.withOpacity(0.3), width: 1)),
        child: Row(children: [
          Icon(icon, size: responsive.hp(2.5), color: color),
          SizedBox(width: responsive.wp(3)),
          Expanded(
              child: Text(text,
                  style: GoogleFonts.poppins(
                      fontSize: responsive.sp(13),
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                      height: 1.4)))
        ]));
  }

  Widget _buildFeatureBox(BuildContext context, ResponsiveUtils responsive,
      {required IconData icon, required String text}) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(size.height * 0.015),
        decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(size.width * 0.04),
            border: Border.all(
                color: AppColors.primary.withOpacity(0.1), width: 1)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: size.height * 0.035, color: AppColors.primary),
              SizedBox(height: size.height * 0.01),
              Text(text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: size.width * 0.035,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      height: 1.4))
            ]));
  }
}
