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
import 'package:sound_mind/core/widgets/custom_text_button.dart';
import 'package:sound_mind/core/widgets/custom_text_field.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> with Validators {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UserAccount) {
          context.replaceNamed(Routes.securityName);
        }
      },
      builder: (BuildContext context, AuthenticationState state) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Assets.application.assets.images.logoPurple
                  .image(width: 132, height: 132)
                  .toCenter(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back,",
                    style: context.textTheme.displayMedium,
                  ),
                  Text(
                    "Login to your SoundMind account",
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _emailController,
                    titleText: "Email",
                    hintText: "Enter your email",
                    enabled: state is! LoginingAccount,
                    validator: validateEmail,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    isPasswordField: true,
                    titleText: "Password",
                    enabled: state is! LoginingAccount,
                    validator: validatePassword,
                    hintText: "",
                  ),
                  CustomTextButton(label: "Forgot Password?", onPressed: () {}),
                ],
              ),
              CustomButton(
                label: "Login",
                notifier: ValueNotifier(state is LoginingAccount),
                onPressed: () {
                  if (!loginForm.currentState!.validate()) return;
                  context.read<AuthenticationBloc>().add(LoginEvent(
                      email: _emailController.text,
                      password: _passwordController.text));
                  setState(() {});
                },
              ),
              RichText(
                text: TextSpan(
                  text: "By continuing you are agreeing to Sound Mind’s ",
                  style: context.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Terms of service',
                      style: context.textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        color: context.primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(
                      text: ' and ',
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(
                      text: 'privacy policy',
                      style: context.textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        color: context.primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ].addSpacer(const Gap(10)),
          ).withSafeArea().withCustomPadding().withForm(loginForm),
          bottomSheet: SizedBox(
            height: 70,
            child: RichText(
              text: TextSpan(
                text: "Don’t have an account? ",
                style: context.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: 'Signup',
                    style: context.textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.underline,
                      color: context.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.pushNamed(Routes.introName);
                      },
                  ),
                ],
              ),
            ).toTop().toCenter(),
          ),
        );
      },
    );
  }
}
