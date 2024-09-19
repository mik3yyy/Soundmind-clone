import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension WidgetExtensions on Widget {
  // Adds padding to a widget
  Widget withPadding([EdgeInsetsGeometry padding = const EdgeInsets.all(8.0)]) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget withCustomPadding() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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

  Widget withExpanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  Widget withSafeArea() {
    return SafeArea(
      child: this,
    );
  }

  Widget withBorder(Border border, {BorderRadius? radius}) {
    return Container(
      decoration: BoxDecoration(border: border, borderRadius: radius),
      child: this,
    );
  }

  Widget withForm(Key key) {
    return Form(
      key: key,
      child: this,
    );
  }

  Widget withHero(String tag) {
    return Hero(
      tag: tag,
      child: this,
    );
  }

  Widget toCenter() {
    return Center(
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

  Widget withClip(double radius,
      {bool? topLeft, bool? topRight, bool? bottomLeft, bool? bottomRight}) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: topLeft != null
            ? const Radius.circular(0)
            : Radius.circular(radius),
        topRight: topRight != null
            ? const Radius.circular(0)
            : Radius.circular(radius),
        bottomLeft: bottomLeft != null
            ? const Radius.circular(0)
            : Radius.circular(radius),
        bottomRight: bottomRight != null
            ? const Radius.circular(0)
            : Radius.circular(radius),
      ),
      child: this,
    );
  }

  Widget toTop() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [this],
    );
  }

  Widget toBottom() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [this],
    );
  }

  Widget toLeft() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [this],
    );
  }

  Widget toRight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [this],
    );
  }
}
