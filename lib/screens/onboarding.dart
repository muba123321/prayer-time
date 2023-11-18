import 'package:flutter/material.dart';
import 'package:islamic_center_prayer_times/providers/onboarding_provider.dart';

import 'package:islamic_center_prayer_times/screens/prayertimescreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:video_player/video_player.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  // late SwiperController swiperController;
  late VideoPlayerController videoontroller;

  @override
  void initState() {
    super.initState();
    // swiperController = SwiperController();
    videoontroller = VideoPlayerController.asset(
      'assets/videos/video.mp4', // Adjust the path accordingly
    )..initialize().then((_) {
        setState(() {}); // Trigger a rebuild when initialization is complete
        videoontroller.play();
        videoontroller.setLooping(true);
        videoontroller.setVolume(0);
        // Ensure the first frame is shown after the video is initialized
      });
  }

  @override
  void dispose() {
    videoontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(builder: (context, notifier, __) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: videoontroller.value.size.width,
                  height: videoontroller.value.size.height,
                  child: VideoPlayer(videoontroller),
                ),
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
                          control: const SwiperControl(),
                          itemHeight: double.infinity,
                          itemWidth: double.infinity,
                          indicatorLayout: PageIndicatorLayout.WARM,
                          layout: SwiperLayout.DEFAULT,
                          onIndexChanged: (value) {
                            notifier.selectedIndex(value);
                            notifier.swiperController.index = value;
                            print('This is the value $value');
                            print(
                                'This is the controller ${notifier.swiperController.index}');
                          },
                          index: 0,
                          curve: Curves.ease,
                          physics: const ClampingScrollPhysics(),
                          itemCount: 3, // Number of onboarding cards
                          itemBuilder: (BuildContext context, int index) {
                            return OnboardingCard(index: index);
                          },
                          pagination: const SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                                color: Color(0xFFFFFFFF),
                                activeColor: Color(0xFF772f30)),

                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.all(8.0),
                            // Set the colors for active and inactive dots
                          ),
                          loop: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            if (current != 0)
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: const ButtonStyle(
                                        // backgroundColor: MaterialStatePropertyAll(
                                        //     Color(0xFF772f30)),
                                        side: MaterialStatePropertyAll(
                                            BorderSide(
                                                width: 2,
                                                color: Color(0xFF772f30)))),
                                    onPressed: () {
                                      notifier.swiperController
                                          .previous(animation: true);
                                    },
                                    child: Center(
                                        child: Text(
                                      'Back',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 16,
                                        color: const Color(0xFF772f30),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF772f30)),
                                  ),
                                  onPressed: () {
                                    if (notifier.swiperController.index < 2) {
                                      notifier.swiperController
                                          .next(animation: true);
                                      print(
                                          'This is swip index ${notifier.swiperController.index}');
                                    } else {
                                      _finishOnboarding();
                                    }
                                  },
                                  child: Center(
                                      child: Text(
                                    current == 2
                                        ? 'Done'
                                        : 'Next', // Change this line
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 16,
                                      color: const Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      );
    });
  }

  Future<void> _finishOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboarding', true);
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PrayerTimesScreen(),
        ),
      );
    }
  }
}

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

class FeatureListItem extends StatelessWidget {
  final IconData icon;
  final String description;

  const FeatureListItem(
      {super.key, required this.icon, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
          const SizedBox(width: 10.0),
          Container(
            color: Colors.black.withOpacity(0.6),
            child: Text(
              description,
              style: GoogleFonts.aBeeZee(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
