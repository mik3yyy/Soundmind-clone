import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/presentation/views/appointment_page.dart';
import 'package:sound_mind/features/appointment/presentation/views/booking/view_booking.dart';
import 'package:sound_mind/features/appointment/presentation/views/booking/view_day.dart';
import 'package:sound_mind/features/appointment/presentation/views/booking/view_time.dart';
import 'package:sound_mind/features/appointment/presentation/views/view_doctor.dart';
import 'package:sound_mind/features/chat/data/models/chat_room.dart';
import 'package:sound_mind/features/chat/presentation/views/chat_page.dart';
import 'package:sound_mind/features/chat/presentation/views/chat_room.dart';
import 'package:sound_mind/features/main/presentation/views/home_screen/home_screen.dart';
import 'package:sound_mind/features/main/presentation/views/home_screen/view_session.dart';
import 'package:sound_mind/features/main/presentation/views/main_page.dart';
import 'package:sound_mind/features/notification/presentation/views/notification_page.dart';
import 'package:sound_mind/features/setting/presentation/views/change_password.dart';
import 'package:sound_mind/features/setting/presentation/views/change_pin.dart';
import 'package:sound_mind/features/setting/presentation/views/new_pin.dart';
import 'package:sound_mind/features/setting/presentation/views/personal_details.dart';
import 'package:sound_mind/features/setting/presentation/views/setting_page.dart';
import 'package:sound_mind/features/wallet/presentation/views/withdraw_amount.dart';
import 'package:sound_mind/features/wallet/presentation/views/add_funds.dart';
import 'package:sound_mind/features/wallet/presentation/views/wallet_page.dart';
import 'package:sound_mind/features/wallet/presentation/views/withdraw_page.dart';

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
  static const String chatName = 'chat';
  static const String chatRoomPath = 'room/:id'; // Avoid redundancy
  static const String chatRoomName = 'chatRoom';
  static const String settingsPath = 'settings';

  static const String settingsName = 'settings';

  static const String viewTimePath = 'viewTime';
  static const String viewTimeName = 'viewTime';

  static const String addFundPath = 'addFund';
  static const String addFundName = 'addFund';

  static const String withdrawPath = 'withdraw';
  static const String withdrawName = 'withdraw';

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

  static const String viewSessionName = 'viewSession';
  static const String viewSessionPath = 'viewSession';

  static const String createAccountName = 'createAccount';

  static const String createAccountPath = 'createAccount';

  static const String add_amountName = 'add_amount';
  static const String add_amountPath = 'add_amount';

  static const String loginName = 'login';
  static const String loginPath = 'login';

  static const String notificationName = 'notification';
  static const String notificationPath = 'notification';

  static const String verifyName = 'verify';
  static const String verifyPath = '/verify';
  static const String securityName = 'security';
  static const String securityPath = '/security';

  static const String personal_detailsName = 'personal_details';
  static const String personal_detailsPath = 'personal_details';

  static const String change_passwordName = 'change_password';
  static const String change_passwordPath = 'change_password';

  static const String change_pinName = 'change_pin';
  static const String change_pinPath = 'change_pin';

  static const String input_new_pinName = 'input_new_pin';
  static const String input_new_pinPath = 'input_new_pin';

  static const String view_bookingName = 'view_booking';
  static const String view_bookingPath = 'view_booking';
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
            builder: (context, state) => OnboardingScreen(
              page: state.extra,
            ), // Replace with actual screen widget
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
          routeState: state,
        ),
        routes: [
          GoRoute(
              path: homePath,
              name: homeName,
              parentNavigatorKey: shellNavigatorKey,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const HomeScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
              // builder: (context, state) =>
              //     HomeScreen(),
              routes: [
                GoRoute(
                  path: viewSessionPath,
                  name: viewSessionName,
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => ViewSessionScreen(
                    appointment: state.extra as AppointmentDto,
                  ),
                ),
                GoRoute(
                  path: view_bookingPath,
                  name: view_bookingName,
                  parentNavigatorKey: rootNavigatorKey,

                  builder: (context, state) =>
                      ViewBookingScreen(), // Replace with actual screen widget
                ),
                GoRoute(
                  path: notificationPath,
                  name: notificationName,
                  parentNavigatorKey: rootNavigatorKey,

                  builder: (context, state) =>
                      NotificationPage(), // Replace with actual screen widget
                ),
                GoRoute(
                  path: settingsPath,
                  name: settingsName,
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) =>
                      SettingPage(), // Replace with actual screen widget
                  routes: [
                    GoRoute(
                      path: termsOfService,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (context, state) =>
                          Placeholder(), // Replace with actual screen widget
                    ),
                    GoRoute(
                      path: personal_detailsPath,
                      name: personal_detailsName,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (context, state) =>
                          const PersonalDetailsScreen(),
                    ),
                    GoRoute(
                      path: change_passwordPath,
                      name: change_passwordName,
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (context, state) => ChangePasswordScreen(),
                    ),
                    GoRoute(
                        path: change_pinPath,
                        name: change_pinName,
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) => ChangePinScreen(),
                        routes: [
                          GoRoute(
                            path: input_new_pinPath,
                            name: input_new_pinName,
                            parentNavigatorKey: rootNavigatorKey,
                            builder: (context, state) => NewPinScreen(),
                          ),
                        ]),
                  ],
                ),
              ]),
          GoRoute(
              path: chatPath,
              name: chatName,
              parentNavigatorKey: shellNavigatorKey,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const ChatPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
              routes: [
                GoRoute(
                  path: chatRoomPath,
                  name: chatRoomName,
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => ChattRoomScreen(
                    chat_id: int.parse(state.pathParameters['id']!),
                    user_id: state.extra as ChatRoomDto,
                  ),
                ),
              ]),
          GoRoute(
            path: findADocPath,
            name: findADocName,
            parentNavigatorKey: shellNavigatorKey,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: AppointmentPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            },
            // builder: (context, state) => AppointmentPage(),
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
              // builder: (context, state) =>
              //     WalletPage(), // Replace with actual screen widget
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: WalletPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
              routes: [
                GoRoute(
                  path: addFundPath,
                  name: addFundName,
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) =>
                      const AddFundsPage(), // Replace with actual screen widget
                ),
                GoRoute(
                    path: withdrawPath,
                    name: withdrawName,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) =>
                        const WithdrawPage(), // Replace with actual screen widget
                    routes: [
                      GoRoute(
                        path: add_amountPath,
                        name: add_amountName,
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) => AddAmountPage(
                          number: state.extra as String,
                          bank: state.uri.queryParameters,
                        ), // Replace with actual screen widget
                      ),
                    ]),
              ]),
        ],
      ),
    ],
  );
}
