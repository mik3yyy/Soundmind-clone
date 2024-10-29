import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/routes/routes.dart';

void showLogoutConfirmationDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Are you sure?',
          style: context.textTheme.displayMedium,
        ),
        content: Text('Do you really want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              deleteAllData();
              context.pushReplacementNamed(Routes.onboardingName, extra: 2);
              // Perform the logout operation
              // For example, trigger the LogoutEvent
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}

Future<void> deleteAllData() async {
  // Get the Hive box
  var box = Hive.box('userBox');

  // Clear all data in the box
  await box.clear();
}
