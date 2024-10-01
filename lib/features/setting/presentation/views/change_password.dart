import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/utils/validators.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/core/widgets/custom_phone_number_field.dart';
import 'package:sound_mind/core/widgets/custom_text_field.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/change_password/change_password_cubit.dart';
import 'package:sound_mind/features/Authentication/presentation/views/create_account/create_account.dart';
import 'package:sound_mind/features/setting/presentation/widgets/sucess_change_password.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with Validators {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final changeForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          showDialog(
              useSafeArea: false,
              context: context,
              builder: (context) => SucessfulChangePassword());
        } else if (state is ChangePasswordError) {
          context.showSnackBar(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: context.colors.black,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Change your Password",
              style: context.textTheme.displayMedium,
            ),
            const Text(
              "Update your password if you feel your account has been compromised.",
            ),
            Gap(20),
            CustomTextField(
              controller: _oldpasswordController,
              isPasswordField: true,
              titleText: "Old Password",
              validator: validatePassword,
              onChanged: (value) {
                setState(() {});
              },
              hintText: "",
            ),
            const Gap(10),
            CustomTextField(
              controller: _passwordController,
              isPasswordField: true,
              titleText: "New Password",
              validator: validatePassword,
              hintText: "",
              onChanged: (value) {
                setState(() {});
              },
            ),
            const Gap(10),
            CustomTextField(
              controller: _cpasswordController,
              isPasswordField: true,
              validator: (value) => validateConfirmPassword(
                  passowrd: _passwordController.text, confirmPassword: value),
              titleText: "Confirm Password",
              hintText: "",
              onChanged: (value) {
                setState(() {});
              },
            ),
          ],
        ).withSafeArea().withCustomPadding().withForm(changeForm),
        bottomNavigationBar: SizedBox(
          height: 150,
          child: CustomButton(
            label: "Save",
            enable: _cpasswordController.text.isNotEmpty &&
                _oldpasswordController.text.isNotEmpty &&
                _passwordController.text.isNotEmpty,
            onPressed: () {
              if (!changeForm.currentState!.validate()) return;

              context.read<ChangePasswordCubit>().changePassword(
                  oldPassword: _oldpasswordController.text,
                  newPassword: _passwordController.text,
                  confirmPassword: _cpasswordController.text);
            },
          ).toCenter(),
        ),
      ),
    );
  }
}
