import 'package:flutter/material.dart';

class CustomSizeTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SizeTransition(
      sizeFactor: animation,
      child: child,
    );
  }
}
