import 'package:flutter/material.dart';
import 'package:islamic_center_prayer_times/providers/onboarding_provider.dart';
import 'package:islamic_center_prayer_times/pages/homepage.dart';
import 'package:islamic_center_prayer_times/widgets/onboarding_widgets/onboarding_card.dart';
import 'package:provider/provider.dart';
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
    // swiperController.dispose(); // Add this line
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
                          },
                          index: notifier.currentIndex,
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
                                        side: MaterialStatePropertyAll(
                                            BorderSide(
                                                width: 2,
                                                color: Color(0xFF772f30)))),
                                    onPressed: () {
                                      notifier.swiperController.previous();
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
                                      notifier.swiperController.next();
                                    } else {
                                      context
                                          .read<OnboardingProvider>()
                                          .finishOnboarding()
                                          .then((value) => Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage(),
                                                ),
                                              ));
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
}
