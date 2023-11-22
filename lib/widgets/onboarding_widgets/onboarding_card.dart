import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_center_prayer_times/widgets/onboarding_widgets/onboarding_featureditems.dart';

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
        color: index != 1
            ? Colors.white.withAlpha(200)
            : const Color(0xFF772f30).withAlpha(200),
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
                  'assets/images/logo.png',
                  height: 200,
                  width: 200,
                ),
                const Spacer(),
                Text(
                  'The Islamic Center Of Greater Cincinnati (ICGC)',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 28,
                    color: const Color(0xFF772f30),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Spacer(),
                Text(
                  'Prayer Times',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 24,
                    color: const Color(0xFF772f30),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  'Onboarding Card $index',
                  style: const TextStyle(fontSize: 20.0),
                ),
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

                Image.asset('assets/images/salat.png'),
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
                                top: 60, left: 16, bottom: 80),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.black.withOpacity(0.6),
                                  child: Text(
                                    'Enjoy the App Features...',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
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
                                  icon: Icons.language,
                                  description: 'Support for Multiple Languages',
                                ),
                              ],
                            ))
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
