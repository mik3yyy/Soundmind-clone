import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';

class SucessfulChangePassword extends StatefulWidget {
  const SucessfulChangePassword({super.key});

  @override
  State<SucessfulChangePassword> createState() =>
      _SucessfulChangePasswordState();
}

class _SucessfulChangePasswordState extends State<SucessfulChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        height: context.screenHeight,
        width: context.screenWidth * 1.2,
        color: Colors.black.withOpacity(.7),
        child: Container(
          padding: EdgeInsets.all(8),
          height: context.screenHeight * .28,
          width: context.screenWidth * .8,
          decoration: BoxDecoration(
            color: context.colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Assets.application.assets.svgs.vector.svg(),
              AutoSizeText(
                "Changed Password Succesfully",
                textAlign: TextAlign.center,
                style: context.textTheme.displayMedium,
              ),
              CustomButton(
                  label: "Continue",
                  onPressed: () {
                    context.goNamed(Routes.homeName);
                  })
            ],
          ),
        ).toCenter(),
      ),
    );
  }
}
