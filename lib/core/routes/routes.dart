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

// Define route constants
class Routes {
  static const String home = '/';
  static const String chat = '/chat';
  static const String settings = '/settings';
  static const String termsOfService = 'terms-of-services';

  static const String splashName = 'splash';
  static const String splashPath = '/';

  static const String onboardingName = 'onboarding';
  static const String onboardingPath = 'onboarding';

  static const String introName = 'intro';
  static const String introPath = 'intro';

  static const String questionName = 'question';
  static const String questionPath = 'question';

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
          )
        ],
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
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => Placeholder(),
        routes: [
          GoRoute(
            path: home,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) =>
                Placeholder(), // Replace with actual screen widget
          ),
          GoRoute(
            path: chat,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) =>
                Placeholder(), // Replace with actual screen widget
          ),
          GoRoute(
            path: settings,
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
