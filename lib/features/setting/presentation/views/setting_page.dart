import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/widgets/custom_text_button.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/Security/presentation/blocs/Security_bloc.dart';
import 'package:sound_mind/features/wallet/presentation/views/withdraw_page.dart';
import '../blocs/setting_bloc.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
        centerTitle: false,
        leading: BackButton(
          color: context.colors.black,
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              UserModel userModel = (state as UserAccount).user;
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Personal details",
                          style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: context.primaryColor),
                        ),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: Icon(Icons.chevron_right_rounded)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: const Text("Name"),
                        subtitle: Text(
                            "${userModel.firstName} ${userModel.lastName}"),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: const Text("Email"),
                        subtitle: Text("${userModel.email} "),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text("Phone number"),
                        subtitle: Text("${userModel.phoneNumber}"),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notification and Security",
                  style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: context.primaryColor),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.toggle_on,
                  color: context.colors.green,
                )),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Change PIN"),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
          ListTile(
            leading: Icon(Icons.fingerprint),
            title: Text("Enable Biometrics"),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.toggle_on)),
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text("Change Password"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chevron_right,
              ),
            ),
          ),
          ListTile(
            leading: Assets.application.assets.images.logoPurple
                .image(height: 32, width: 32),
            title: Text("About"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chevron_right,
              ),
            ),
          ),
        ],
      ).withSafeArea().withCustomPadding(),
      bottomNavigationBar: Container(
        height: 150,
        child: CustomTextButton(
          label: "Log out",
          onPressed: () {},
          textStyle: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colors.red,
            fontSize: 16,
          ),
        ).toCenter(),
      ),
    );
  }
}
