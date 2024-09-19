import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/features/Authentication/presentation/views/create_account/verify_email.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sound_mind/features/Security/presentation/blocs/Security_bloc.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SecurityBloc, SecurityState>(
      listener: (context, state) {
        if (state is SetPinPage) {
          context.goNamed(Routes.setPinName);
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Assets.application.assets.svgs.fi16973516.svg(),
            const Gap(10),
            AutoSizeText(
              "Secure your account info",
              style: context.textTheme.displayMedium,
            ),
            AutoSizeText(
              "Create a Two-factor authentication for better security for your accounts, also helps you sign in faster ",
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colors.black,
              ),
            ),
            const Gap(20),
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Assets.application.assets.images.fingerprint.image(),
                  title: Text(
                    "Enable Biometrics",
                    style: context.textTheme.displaySmall
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
                const Gap(10),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Assets.application.assets.images.lockPin.image(),
                  title: Text(
                    "Set up PIN authentiction ",
                    style: context.textTheme.displaySmall
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ],
        ).withSafeArea().withCustomPadding(),
        bottomSheet: Container(
          height: 150,
          child: CustomButton(
            label: "Continue",
            onPressed: () async {
              // ···
              // ···
              final bool canAuthenticateWithBiometrics =
                  await auth.canCheckBiometrics;
              final bool canAuthenticate = canAuthenticateWithBiometrics ||
                  await auth.isDeviceSupported();
              try {
                final bool didAuthenticate = await auth.authenticate(
                    localizedReason:
                        'Please authenticate to show account balance',
                    options: AuthenticationOptions(biometricOnly: true));
                // ···
              } on PlatformException {
                // ...
              }
              context.read<SecurityBloc>().add(GoToPinPage());
            },
          ).toCenter(),
        ),
      ),
    );
  }
}
