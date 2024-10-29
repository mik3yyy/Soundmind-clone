import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/list_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/gen/fonts.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, this.page});
  final Object? page;
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  bool lastpage = false;
  int currentPage = 0;
  final btnNotifier = ValueNotifier(false);
  List<Map<String, dynamic>> welcomeTexts = [
    {
      'title': 'Welcome! Let SoundMind help personlize your experience',
      'subTitle':
          'We will be asking you a series of questions to help us better understand you and your health',
    },
    {
      'title': 'Welcome! Let SoundMind help personlize your experience',
      'subTitle':
          'We will be asking you a series of questions to help us better understand you and your health'
    },
    {
      'title': 'Welcome! Let SoundMind help personlize your experience',
      'subTitle':
          'We will be asking you a series of questions to help us better understand you and your health',
    },
  ];
  List<Widget> images = [
    Assets.application.assets.images.onboardingImages.a1.image(
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
    ),
    Assets.application.assets.images.onboardingImages.a2.image(
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
    ),
    Assets.application.assets.images.onboardingImages.a3.image(
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.page != null) {
      _pageController = PageController(initialPage: (widget.page as int));
      currentPage = (widget.page as int);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    currentPage = value;
                    if (value == 3) {
                      setState(() {
                        lastpage = true;
                      });
                    } else {
                      setState(() {
                        lastpage = false;
                      });
                    }
                  },
                  controller: _pageController,
                  itemBuilder: (context, index) => buildOnboardingPage(
                    context,
                    images[index],
                    welcomeTexts[index]['title'],
                    welcomeTexts[index]['subTitle'],
                  ),
                  itemCount: welcomeTexts.length,
                ),
              ),
              if (currentPage == 2) ...[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.sizeOf(context).width,
                  height: 150,
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        label: "Get Started",
                        notifier: btnNotifier,
                        onPressed: () {
                          context.replaceNamed(Routes.introName);
                        },
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          children: [
                            TextSpan(
                              text: 'Log in',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.replaceNamed(Routes.loginName);
                                },
                            ),
                          ],
                        ),
                      )
                    ].addSpacer(const Gap(20)),
                  ),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.sizeOf(context).width,
                  height: 150,
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        label: "Next",
                        notifier: btnNotifier,
                        onPressed: () {
                          currentPage++;
                          _pageController.animateToPage(currentPage,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.decelerate);
                          // context.replaceNamed(Routes.auth);
                        },
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
          if (currentPage != 2)
            Positioned(
              top: 60,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  currentPage = 2;
                  _pageController.animateToPage(
                    currentPage,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text("Skip",
                    style: context.textTheme.titleMedium
                        ?.copyWith(color: context.colors.white)),
              ),
            ),
          Positioned(
            bottom: 310,
            child: SizedBox(
              width: context.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: welcomeTexts.length,
                    effect: WormEffect(
                      dotWidth: 8,
                      dotHeight: 8,
                      dotColor: context.colors.greyDecorDark,
                      activeDotColor: context.colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildOnboardingPage(
    BuildContext context,
    Widget image,
    String title,
    String body,
  ) {
    return Stack(
      children: [
        Positioned.fill(child: image),
        Positioned(
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.3, 1],
              ),
            ),
            height: 150,
            width: context.screenWidth,
            child: Column(
              children: [
                SizedBox(
                  width: context.screenWidth * .96,
                  // height: 80,
                  child: Center(
                    child: AutoSizeText(
                      title,
                      textAlign: TextAlign.center,
                      style: context.textTheme.displayLarge
                          ?.copyWith(color: context.colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: context.screenWidth * .9,
                  child: AutoSizeText(
                    body,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: context.colors.white),
                  ),
                )
              ].addSpacer(const Gap(20)),
            ),
          ),
        ),
      ],
    );
  }
}
