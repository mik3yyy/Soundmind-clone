import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/Security/presentation/blocs/Security_bloc.dart';

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

    context.read<AuthenticationBloc>().add(CheckUser());
    // goToOnboardingScreen();
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
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state is UserAccount) {
          context.read<SecurityBloc>().add(isPinSet());
        }
        if (state is SetUserState) {
          await Future.delayed(const Duration(seconds: 2));
          context.replaceNamed(Routes.onboardingName);
        }
      },
      child: BlocListener<SecurityBloc, SecurityState>(
        listener: (context, state) async {
          if (state is VerifyPinPage) {
            await Future.delayed(const Duration(seconds: 2));
            context.replaceNamed(Routes.pinhName);
          } else {
            await Future.delayed(const Duration(seconds: 2));
            context.replaceNamed(Routes.securityName);
          }
        },
        child: Scaffold(
          backgroundColor: context.primaryColor,
          body: Center(
            child: Assets.application.assets.images.splashImage
                .image()
                .withPadding(const EdgeInsets.symmetric(horizontal: 20)),
          ),
        ),
      ),
    );
  }
}
