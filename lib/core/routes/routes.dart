import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Define route constants
class Routes {
  static const String home = '/';
  static const String chat = '/chat';
  static const String settings = '/settings';
  static const String termsOfService = 'terms-of-services';

  // Navigator keys for nested navigation
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => Placeholder(),
        routes: [
          GoRoute(
            path: home,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) => Placeholder(), // Replace with actual screen widget
          ),
          GoRoute(
            path: chat,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) => Placeholder(), // Replace with actual screen widget
          ),
          GoRoute(
            path: settings,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) => Placeholder(), // Replace with actual screen widget
            routes: [
              GoRoute(
                path: termsOfService,
                parentNavigatorKey: rootNavigatorKey,
                builder: (context, state) => Placeholder(), // Replace with actual screen widget
              ),
            ],
          ),
        ],
      ),
    ],
  );
}



