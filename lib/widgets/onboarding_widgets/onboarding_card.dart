import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gicc/widgets/onboarding_widgets/onboarding_featureditems.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingCard extends StatelessWidget {
  final int index;

  const OnboardingCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 80.0, left: 16, right: 16, bottom: 30),
      child: Card(
        surfaceTintColor: Colors.transparent,
        color:
            index != 1 ? Colors.white : const Color(0xFF005015).withAlpha(200),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: index != 2
              ? const EdgeInsets.only(top: 20.0, bottom: 20)
              : const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Customize your card content based on the index
              if (index == 0) ...[
                Image.asset(
                  'assets/images/gaskia.png',
                  height: 200,
                ),
                const Spacer(),
                Container(
                  height: 160,
                  width: 280,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xFF005015),
                            offset: Offset(3, 4),
                            blurRadius: 1,
                            blurStyle: BlurStyle.solid),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(width: 2, color: const Color(0xFF005015))),
                  child: Center(
                    child: Text(
                      'Gaskia Islamic Community Center (GICC)',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 32,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'MASJID APPLICATION',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 24,
                    color: const Color(0xFF005015),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                // Text(
                //   'Onboarding Card $index',
                //   style: const TextStyle(fontSize: 20.0),
                // ),
              ] else if (index == 1) ...[
                // Content for the second card
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'The Prayer time on this app is set for this Masjid only',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 24,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),

                Stack(
                  children: [
                    Image.asset('assets/images/salat.png'),
                    Positioned(
                      bottom: 0,
                      right: 9,
                      child: GestureDetector(
                        onTap: () async {
                          const url =
                              'https://www.freepik.com/icon/islam_13801087#fromView=search&page=1&position=64&uuid=89e9a6e1-a534-46b1-a6ed-096bd7469a4b';
                          if (await launchUrl(Uri.parse(url),
                              mode: LaunchMode.externalApplication)) {
                            await launchUrl(Uri.parse(url),
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          'Icon by adriansyah',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 8,
                            color: const Color(0xFFFFFFFF),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'The Prayer time will not change if you move to a different location',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 18,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ] else if (index == 2) ...[
                // Content for the third card
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.hardEdge,
                      children: [
                        Image.asset(
                          'assets/images/inside.jpg',
                          fit: BoxFit.fill,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 16, right: 16, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Enjoy the App Features...',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 33,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const FeatureListItem(
                                  icon: Icons.access_time,
                                  description: 'Accurate Prayer Timings',
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const FeatureListItem(
                                  icon: Icons.notifications,
                                  description: 'Inbuilt Prayer Alerts',
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const FeatureListItem(
                                  icon: Icons.location_on,
                                  description: 'Jumah Prayer Sessions',
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const FeatureListItem(
                                  icon: Icons.calendar_today,
                                  description: 'Islamic Calendar Events',
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const FeatureListItem(
                                  icon: Icons.announcement_rounded,
                                  description: 'Events and Announcements',
                                ),
                                const FeatureListItem(
                                  icon: Icons.help_outline_rounded,
                                  description: 'Community Services',
                                ),
                              ],
                            )),
                        Positioned(
                          bottom: 0,
                          right: 9,
                          child: GestureDetector(
                            onTap: () async {
                              const url =
                                  'https://www.freepik.com/free-ai-image/view-3d-islamic-mosque_133520409.htm#fromView=image_search_similar&page=3&position=10&uuid=0afd6a59-595e-470d-b3a2-106f05d2c69f';
                              if (await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication)) {
                                await launchUrl(Uri.parse(url),
                                    mode: LaunchMode.externalApplication);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Text(
                              'Image by Freepik',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 8,
                                color: const Color(0xFF005015),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
