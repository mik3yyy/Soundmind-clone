import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/utils/validators.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/core/widgets/custom_phone_number_field.dart';
import 'package:sound_mind/core/widgets/custom_text_field.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/update_user/update_user_cubit.dart';
import 'package:sound_mind/features/wallet/presentation/views/withdraw_page.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen>
    with Validators {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lasttNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String phoneNumber = '';
  final updateForm = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var user = (context.read<AuthenticationBloc>().state as UserAccount).user;

    _firstNameController.text = user.firstName;
    _lasttNameController.text = user.lastName;
    _phoneNumberController.text = user.phoneNumber.substring(4);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserCubit, UpdateUserState>(
      listener: (context, state) {
        if (state is UpdateUserSuccess) {
          context.read<AuthenticationBloc>().add(UpdateUser());
          context.pop();
        }
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: context.colors.black,
          ),
          title: Text('Personal details'),
          centerTitle: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _firstNameController,
              titleText: "First name",
              hintText: "Enter your first name",
              validator: validateName,
            ),
            Gap(10),
            CustomTextField(
              controller: _lasttNameController,
              titleText: "Last name",
              validator: validateName,
              hintText: "Enter your last name",
            ),
            Gap(10),
            const Text("Phone number"),
            CustomPhoneNumber(
              phoneNumberController: _phoneNumberController,
              phoneNumberValue: (String fullNumber) {
                phoneNumber = fullNumber;
              },
            ),
          ],
        ).withSafeArea().withCustomPadding().withForm(updateForm),
        bottomNavigationBar: Container(
          height: 200,
          child: CustomButton(
              label: "Save",
              onPressed: () {
                if (!updateForm.currentState!.validate()) return;

                context.read<UpdateUserCubit>().updateUser(
                    firstName: _firstNameController.text,
                    lastName: _lasttNameController.text,
                    phoneNumber: phoneNumber);
              }).toCenter(),
        ),
      ),
    );
  }
}
