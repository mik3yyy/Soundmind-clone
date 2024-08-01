import 'package:flutter/material.dart';

extension ListExtension on List<Widget> {
  List<Widget> addSpacer(Widget spacer) {
    List<Widget> spacedList = [];
    for (int i = 0; i < length; i++) {
      spacedList.add(this[i]);
      if (i < length - 1) {
        spacedList.add(spacer);
      }
    }
    return spacedList;
  }
}
