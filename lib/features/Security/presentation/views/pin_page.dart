import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/routes/routes.dart';
import 'package:sound_mind/core/services/injection_container.dart';
import 'package:sound_mind/core/widgets/custom_text_button.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/Security/presentation/blocs/Security_bloc.dart';
import 'package:sound_mind/features/setting/presentation/widgets/are_you_sure.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  @override
  Widget build(BuildContext context) {
    return PinInputScreen();
  }
}

class PinInputScreen extends StatefulWidget {
  @override
  _PinInputScreenState createState() => _PinInputScreenState();
}

class _PinInputScreenState extends State<PinInputScreen> {
  String pin = '';
  final LocalAuthentication auth = LocalAuthentication();
  var box = Hive.box('userBox');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bool enableBiometrics = box.get("EB", defaultValue: true);
    if (enableBiometrics) {
      setAuth();
    }
  }

  setAuth() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: AuthenticationOptions(biometricOnly: true));
      // ···
    } on PlatformException {
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SecurityBloc, SecurityState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthenticatedState) {
          context.goNamed(Routes.homeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  showLogoutConfirmationDialog(context);
                },
                icon: Icon(
                  Icons.logout,
                  color: context.primaryColor,
                ))
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Gap(30),
              const Icon(
                Icons.lock,
                size: 40,
                color: Colors.black,
              ),
              const SizedBox(height: 20),
              const Text(
                "Confirm your new PIN",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: index < pin.length
                          ? Colors.black
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              BlocBuilder<SecurityBloc, SecurityState>(
                builder: (context, state) {
                  if (state is AuthenticationFailureState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Gap(20),
                        Text(
                          "Wrong pin",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: context.colors.red),
                        ),
                        Gap(20),
                      ],
                    );
                  }

                  return Gap(50);
                },
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    if (index < 9) {
                      return PinButton(
                        number: (index + 1).toString(),
                        onTap: () => _onNumberTap((index + 1).toString()),
                      );
                    } else if (index == 9) {
                      return box.get("EB", defaultValue: true) == true
                          ? GestureDetector(
                              onTap: _onFingerprintTap,
                              child: Icon(Icons.fingerprint, size: 80),
                            )
                          : Container(
                              width: 100,
                            ); // Fingerprint icon on the left
                    } else if (index == 10) {
                      return PinButton(
                        number: '0',
                        onTap: () => _onNumberTap('0'),
                      );
                    } else {
                      return GestureDetector(
                        onTap: _onBackspaceTap,
                        child: Icon(Icons.backspace, size: 40),
                      ); // Backspace icon on the right
                    }
                  },
                ),
              ),
            ],
          ),
        ).withSafeArea(),
        // bottomNavigationBar: Container(
        //   height: 50,
        //   child: CustomTextButton(
        //     label: "Log out?",
        //     textStyle: context.textTheme.titleMedium?.copyWith(
        //       color: context.primaryColor,
        //     ),
        //     onPressed: () {
        //       context.read<AuthenticationBloc>().add(LogoutEvent());

        //       sl<Box>().deleteAll(["securityBox"]);

        //       context.replaceNamed(Routes.splashName);
        //     },
        //   ),
        // ),
      ),
    );
  }

  void _onNumberTap(String number) {
    if (pin.length < 6) {
      setState(() {
        pin += number;
      });
    }
    if (pin.length == 6) {
      context.read<SecurityBloc>().add(AuthenticateEvent(pin: pin));
      // Handle PIN confirmation
    }
  }

  void _onBackspaceTap() {
    setState(() {
      if (pin.isNotEmpty) {
        pin = pin.substring(0, pin.length - 1);
      }
    });
  }

  void _onFingerprintTap() {
    setAuth();
    // Handle fingerprint authentication
  }
}

class PinButton extends StatelessWidget {
  final String number;
  final VoidCallback onTap;

  PinButton({required this.number, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
