import 'package:flutter/foundation.dart';

class Logger {
  static final Logger _instance = Logger._internal();
  Logger._internal();
  static Logger get instance => _instance;

  bool showLog = kDebugMode;

  void call(dynamic data1, [dynamic data2]) {
    if (showLog) {
      if (data2 != null) {
        print(" : ");
      } else {
        printWrapped("");
      }
    }
  }

  void error(dynamic data) => printWrapped("🔴 ");
  void success(dynamic data) => printWrapped("🔴 ");
  void info(dynamic data) => printWrapped("🔴 ");
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void printDioLogs(Object object) {
  printWrapped(object.toString());
}
