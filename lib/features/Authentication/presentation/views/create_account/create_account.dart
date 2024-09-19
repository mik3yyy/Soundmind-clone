import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_field/intl_phone_number_field.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/list_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/constants.dart';
import 'package:sound_mind/core/utils/date_formater.dart';
import 'package:sound_mind/core/utils/validators.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/core/widgets/custom_date_picker.dart';
import 'package:sound_mind/core/widgets/custom_dropdown_widget.dart';
import 'package:sound_mind/core/widgets/custom_phone_number_field.dart';
import 'package:sound_mind/core/widgets/custom_text_field.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key, required this.depressionScore});
  final double depressionScore;
  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with Validators {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lasttNameController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String phoneNumber = '';
  final signupForm = GlobalKey<FormState>();
  String? gender;
  String? dob;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is VerifyAccount) {
          context.goNamed(Routes.verifyName, extra: _emailController.text);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Assets.application.assets.images.logoPurple.image(
                    height: 40,
                    width: 40,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: context.textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: context.textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.underline,
                            color: context.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushNamed(Routes.loginName);
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Text(
                "Create an Account",
                style: context.textTheme.displayLarge,
              ),
              const Text(
                  "Create an account with SoundMind to give to access to Therapists, tips about your health and many more."),
              CustomTextField(
                controller: _firstNameController,
                titleText: "First name",
                hintText: "Enter your first name",
                validator: validateName,
              ),
              CustomTextField(
                controller: _lasttNameController,
                titleText: "Last name",
                validator: validateName,
                hintText: "Enter your last name",
              ),
              CustomTextField(
                controller: _emailController,
                titleText: "Email",
                hintText: "Enter your email",
                validator: validateEmail,
              ),
              CustomDropdown(
                title: "Gender",
                items: Constants.genders,
                itemToString: (String item) => item,
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
              CustomDatePicker(
                title: "Date of birth",
                onDateChanged: (DateTime dateTime) {
                  setState(() {
                    dob = DateFormater.formatDate(dateTime);
                  });
                },
              ),
              CustomTextField(
                controller: _passwordController,
                isPasswordField: true,
                titleText: "Password",
                validator: validatePassword,
                hintText: "",
              ),
              CustomTextField(
                controller: _cpasswordController,
                isPasswordField: true,
                validator: (value) => validateConfirmPassword(
                    passowrd: _passwordController.text, confirmPassword: value),
                titleText: "Confirm Password",
                hintText: "",
              ),
              const Text("Phone number"),
              CustomPhoneNumber(
                phoneNumberController: _phoneNumberController,
                phoneNumberValue: (String fullNumber) {
                  phoneNumber = fullNumber;
                },
              ),
              const Gap(10),
              CustomButton(
                label: "Sign up",
                onPressed: () async {
                  if (gender == null) {
                    context.showSnackBar("Select Gender");
                    return;
                  }
                  if (dob == null) {
                    context.showSnackBar("Select Date of birth");
                    return;
                  }
                  if (!signupForm.currentState!.validate()) return;
                  context.read<AuthenticationBloc>().add(
                        CreateAccountEvent(
                          firstName: _firstNameController.text,
                          lastName: _lasttNameController.text,
                          email: _emailController.text,
                          dob: dob!,
                          password: _passwordController.text,
                          confirmPassword: _cpasswordController.text,
                          phoneNumber: phoneNumber,
                          gender: Constants.convertGender(gender!),
                          depressionScore: widget.depressionScore.toString(),
                        ),
                      );
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
              const Gap(30)
            ].addSpacer(const Gap(10)),
          ).withForm(signupForm).withSafeArea().withCustomPadding(),
        ),
      ),
    );
  }
}
