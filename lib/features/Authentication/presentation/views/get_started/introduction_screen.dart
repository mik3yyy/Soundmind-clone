import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/list_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.application.assets.images.logoPurple.image(
            height: 120,
            width: 120,
          ),
          AutoSizeText(
            "Welcome! Let SoundMind help personlize your experience",
            style: context.textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          AutoSizeText(
            "We will be asking you a series of questions to help us better understand you and your health",
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          )
        ].addSpacer(const Gap(20)),
      ).withCustomPadding(),
      bottomSheet: SizedBox(
        height: 100,
        width: context.screenWidth,
        child: Column(children: [
          CustomButton(
            label: "Continue",
            onPressed: () {
              context.pushNamed(Routes.questionName);
            },
          )
              .animate()
              .slideY(
                delay: const Duration(milliseconds: 200),
                begin: 1.0,
                end: 0.0,
                duration: const Duration(milliseconds: 500),
              )
              .fadeIn(),
        ]),
      ),
    );
  }
}
