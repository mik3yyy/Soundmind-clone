import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  // Adds padding to a widget
  Widget withPadding([EdgeInsetsGeometry padding = const EdgeInsets.all(8.0)]) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  // Adds margin to a widget
  Widget withMargin([EdgeInsetsGeometry margin = const EdgeInsets.all(8.0)]) {
    return Container(
      margin: margin,
      child: this,
    );
  }

  // Sets the visibility of a widget
  Widget withVisibility(bool isVisible) {
    return Visibility(
      visible: isVisible,
      child: this,
    );
  }

  // Adds a tap gesture to a widget
  Widget withOnTap(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }
}

