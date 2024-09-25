import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/create_account.dart';
import 'package:sound_mind/features/Authentication/presentation/views/create_account/create_account.dart';
import 'package:sound_mind/features/Authentication/presentation/views/create_account/verify_email.dart';
import 'package:sound_mind/features/Authentication/presentation/views/get_started/introduction_screen.dart';
import 'package:sound_mind/features/Authentication/presentation/views/get_started/question_screen.dart';
import 'package:sound_mind/features/Authentication/presentation/views/login/login.dart';
import 'package:sound_mind/features/Onboarding/presentation/views/Onboarding_page.dart';
import 'package:sound_mind/features/Onboarding/presentation/views/Splash_screen.dart';
import 'package:sound_mind/features/Security/presentation/views/Security_page.dart';
import 'package:sound_mind/features/Security/presentation/views/pin_page.dart';
import 'package:sound_mind/features/Security/presentation/views/set_pin_page.dart';
import 'package:sound_mind/features/appointment/presentation/views/appointment_page.dart';
import 'package:sound_mind/features/appointment/presentation/views/booking/view_day.dart';
import 'package:sound_mind/features/appointment/presentation/views/booking/view_summary.dart';
import 'package:sound_mind/features/appointment/presentation/views/booking/view_time.dart';
import 'package:sound_mind/features/appointment/presentation/views/view_doctor.dart';
import 'package:sound_mind/features/main/presentation/views/home_screen/home_screen.dart';
import 'package:sound_mind/features/main/presentation/views/main_page.dart';

// Define route constants
class Routes {
  static const String homeName = 'home';
  static const String homePath = '/home';

  static const String findADocName = 'findADoc';
  static const String findADocPath = '/findADoc';
  static const String walletName = 'wallet';
  static const String walletPath = '/wallet';
  static const String blogName = 'blog';
  static const String blogPath = '/blog';

  static const String chatPath = '/chat';
  static const String chatNAme = 'chat';
  static const String settingsPath = '/settings';

  static const String settingsName = 'settings';

  static const String viewTimePath = 'viewTime';
  static const String viewTimeName = 'viewTime';

  static const String ViewSummaryName = 'ViewSummary';
  static const String ViewSummaryPath = 'ViewSummary';

  static const String viewDayPath = 'viewDay';
  static const String viewDayName = 'viewDay';

  static const String view_docPath = 'view_doc';
  static const String view_docName = 'view_doc';
  static const String termsOfService = 'terms-of-services';

  static const String splashName = 'splash';
  static const String splashPath = '/';
  static const String pinhName = 'pin';
  static const String pinhPath = '/pin';

  static const String onboardingName = 'onboarding';
  static const String onboardingPath = 'onboarding';

  static const String introName = 'intro';
  static const String introPath = 'intro';

  static const String questionName = 'question';
  static const String questionPath = 'question';

  static const String setPinName = 'setPin';
  static const String setPinPath = 'setPin';

  static const String createAccountName = 'createAccount';

  static const String createAccountPath = 'createAccount';

  static const String loginName = 'login';
  static const String loginPath = 'login';
  static const String verifyName = 'verify';
  static const String verifyPath = '/verify';
  static const String securityName = 'security';
  static const String securityPath = '/security';
  // Navigator keys for nested navigation
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: splashPath,
        name: splashName,
        builder: (context, state) =>
            const SplashScreen(), // Replace with actual screen widget
        routes: [
          GoRoute(
            path: onboardingPath,
            name: onboardingName,
            builder: (context, state) =>
                const OnboardingScreen(), // Replace with actual screen widget
            routes: [
              GoRoute(
                path: introPath,
                name: introName,
                builder: (context, state) => const IntroductionScreen(),
                routes: [
                  GoRoute(
                    path: questionPath,
                    name: questionName,
                    builder: (context, state) => const QuestionScreen(),
                    routes: [
                      GoRoute(
                        path: createAccountPath,
                        name: createAccountName,
                        builder: (context, state) => CreateAccountScreen(
                          depressionScore: state.extra as double,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          GoRoute(
            path: loginPath,
            name: loginName,
            builder: (context, state) => const Loginscreen(),
          ),
        ],
      ),
      GoRoute(
        path: pinhPath,
        name: pinhName,
        builder: (context, state) => const PinPage(),
      ),
      GoRoute(
        path: verifyPath,
        name: verifyName,
        builder: (context, state) => VerifyEmailScreen(
          email: state.extra as String,
        ),
      ),
      GoRoute(
          path: securityPath,
          name: securityName,
          builder: (context, state) => const SecurityScreen(),
          routes: [
            GoRoute(
              path: setPinPath,
              name: setPinName,
              builder: (context, state) =>
                  SetPinPage(), // Replace with actual screen widget
            ),
          ]),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => MainPage(
          child: child,
        ),
        routes: [
          GoRoute(
            path: homePath,
            name: homeName,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) =>
                HomeScreen(), // Replace with actual screen widget
          ),
          GoRoute(
            path: chatPath,
            name: chatNAme,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) =>
                Placeholder(), // Replace with actual screen widget
          ),
          GoRoute(
            path: findADocPath,
            name: findADocName,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) => AppointmentPage(),
            routes: [
              GoRoute(
                path: view_docPath,
                name: view_docName,
                parentNavigatorKey: rootNavigatorKey,
                builder: (context, state) => ViewDoctorPage(
                  id: state.extra,
                ),
                routes: [
                  GoRoute(
                      path: viewDayPath,
                      name: viewDayName,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (context, state) => SelectDayPage(
                            id: state.extra,
                          ), // Replace with actual screen widget
                      routes: [
                        GoRoute(
                            path: viewTimePath,
                            name: viewTimeName,
                            parentNavigatorKey: rootNavigatorKey,
                            builder: (context, state) => SelectTimePage(
                                  id: state.extra,
                                  day: state.uri.queryParameters['day']
                                      as String,
                                ),
                            // Replace with actual screen widget
                            routes: [
                              //        GoRoute(
                              // path: ViewSummaryPath,
                              // name: ViewSummaryName,
                              // builder: (context, state) => ViewSummary(
                              //   id: state.extra,
                              //   physicianScheduleModel: state.,
                              // ),
                              // )
                            ]),
                      ]),
                ],
              ),
            ],
          ),
          GoRoute(
            path: blogPath,
            name: blogName,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) =>
                Placeholder(), // Replace with actual screen widget
          ),
          GoRoute(
            path: walletPath,
            name: walletName,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) =>
                Placeholder(), // Replace with actual screen widget
          ),
          GoRoute(
            path: settingsPath,
            name: settingsName,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) =>
                Placeholder(), // Replace with actual screen widget
            routes: [
              GoRoute(
                path: termsOfService,
                parentNavigatorKey: rootNavigatorKey,
                builder: (context, state) =>
                    Placeholder(), // Replace with actual screen widget
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
