import 'package:flutter/material.dart';

class CustomRotationTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return RotationTransition(
      turns: Tween<double>(
        begin: 0.5,
        end: 1.0,
      ).animate(animation),
      child: child,
    );
  }
}
