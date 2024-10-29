import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/list_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/validators.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/core/widgets/custom_text_field.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/cubit/resend_otp_cubit.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key, required this.email});
  final String email;
  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> with Validators {
  final TextEditingController _otpController = TextEditingController();
  final verifyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResendOtpCubit, ResendOtpState>(
      listener: (context, state) {
        if (state is ResendOtpSuccess) {
          context.showSnackBar("Resent Successfully");
        }
        if (state is ResendOtpFailure) {
          context.showSnackBar(state.message);
        }
      },
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is UserAccount) {
            context.replaceNamed(Routes.securityName);
          }
        },
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.application.assets.svgs.email.svg(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Code sent to email",
                    style: context.textTheme.displayLarge,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "A code has been sent to the email ",
                      style: context.textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: ' ${widget.email} ',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text:
                              'enter the code provided in the email to complete the sign up process',
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomTextField(
                controller: _otpController,
                hintText: "e.g 00000",
                validator: validateDigit,
                keyboardType: TextInputType.number,
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                return RichText(
                  text: TextSpan(
                    text: "Didn’t get an email? ",
                    style: context.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'Resend email',
                        style: context.textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.underline,
                          color: context.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (state is VerifyingAccountError) {
                              context
                                  .read<ResendOtpCubit>()
                                  .resendOtp(state.verificationData['data']);
                            } else if (state is VerifyAccount) {
                              context
                                  .read<ResendOtpCubit>()
                                  .resendOtp(state.verificationData['data']);
                            }
                          },
                      ),
                    ],
                  ),
                );
              }).toCenter()
            ].addSpacer(const Gap(20)),
          ).withSafeArea().withCustomPadding().withForm(verifyForm),
          bottomSheet: SizedBox(
            height: 100,
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is VerifingAccount) {
                  // var currentState = state;

                  return CustomButton(
                    label: "Proceed",
                    notifier: ValueNotifier(true),
                    onPressed: () {
                      if (!verifyForm.currentState!.validate()) return;
                      context.read<AuthenticationBloc>().add(VerifyEmailEvent(
                          otp: _otpController.text,
                          verificationData: state.verificationData));
                    },
                  );
                } else if (state is VerifyingAccountError) {
                  return CustomButton(
                    label: "Proceed",
                    onPressed: () {
                      if (!verifyForm.currentState!.validate()) return;
                      context.read<AuthenticationBloc>().add(VerifyEmailEvent(
                          otp: _otpController.text,
                          verificationData: state.verificationData));
                    },
                  );
                } else if (state is VerifyAccount) {
                  return CustomButton(
                    label: "Proceed",
                    onPressed: () {
                      if (!verifyForm.currentState!.validate()) return;
                      context.read<AuthenticationBloc>().add(VerifyEmailEvent(
                          otp: _otpController.text,
                          verificationData: state.verificationData));
                    },
                  );
                }
                return Container();
              },
            ).toTop().toCenter(),
          ),
        ),
      ),
    );
  }
}
