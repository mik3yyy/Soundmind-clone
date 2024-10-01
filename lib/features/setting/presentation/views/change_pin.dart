import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/services/injection_container.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/features/Authentication/presentation/views/create_account/create_account.dart';
import 'package:sound_mind/features/Security/presentation/blocs/Security_bloc.dart';
import 'package:sound_mind/features/Security/presentation/blocs/change_pin/change_pin_cubit.dart';
import 'package:sound_mind/features/Security/presentation/widgets/succesful_widget.dart';

class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({super.key});

  @override
  State<ChangePinScreen> createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  TextEditingController _pinEditingController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.black,
        ),
      ),
      body: BlocListener<ChangePinCubit, ChangePinState>(
        listener: (context, state) {
          if (state is ChangePinSuccess) {
            context.goNamed(Routes.input_new_pinName);
          } else if (state is ChangePinError) {
            context.showSnackBar(state.message);
          }
          // if (state is AuthenticatedState) {
          //   showDialog(
          //       useSafeArea: false,
          //       context: context,
          //       builder: (context) => SuccessfulWidget());
          // }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assets.application.assets.svgs.fi16973516.svg(),
            // const Gap(10),
            AutoSizeText(
              "Change your PIN",
              style: context.textTheme.displayMedium,
            ),
            AutoSizeText(
              "Enter your current pin",
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colors.black,
              ),
            ),
            const Gap(20),
            SizedBox(
              height: 50,
              child: PinInputTextField(
                pinLength: 6,
                decoration: BoxLooseDecoration(
                  strokeColorBuilder: PinListenColorBuilder(
                      context.colors.greyOutline, context.colors.greyOutline),
                  bgColorBuilder: FixedColorBuilder(context.colors.greyOutline),
                  obscureStyle: ObscureStyle(
                    isTextObscure: true!,
                    obscureText: '0',
                  ),
                ),
                controller: _pinEditingController,
                textInputAction: TextInputAction.go,
                enabled: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                onSubmit: (pin) {
                  debugPrint('submit pin:$pin');
                },
                onChanged: (pin) {
                  setState(() {});
                  debugPrint('onChanged execute. pin:$pin');
                },
                enableInteractiveSelection: false,
              ),
            ),
          ],
        ),
      ).withSafeArea().withCustomPadding(),
      bottomSheet: Container(
        height: 150,
        child: CustomButton(
          label: "Proceed",
          enable: _pinEditingController.text.length == 6,
          onPressed: () async {
            context
                .read<ChangePinCubit>()
                .verifyPin(_pinEditingController.text);
          },
        ).toCenter(),
      ),
    );
  }
}
