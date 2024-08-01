import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToOnboardingScreen();
  }

  void goToOnboardingScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        context.replaceNamed(Routes.onboardingName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor,
      body: Center(
        child: Assets.application.assets.images.splashImage
            .image()
            .withPadding(const EdgeInsets.symmetric(horizontal: 20)),
      ),
    );
  }
}
