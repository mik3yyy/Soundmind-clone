import 'package:intl/intl.dart';

class DateFormater {
  static String formatDate(DateTime dateTime) {
    final year = dateTime.year;
    final month =
        dateTime.month.toString().padLeft(2, '0'); // Ensures two-digit month
    final day =
        dateTime.day.toString().padLeft(2, '0'); // Ensures two-digit day

    return '$year-$month-$day';
  }

  String formatTimeRange(String startTimeStr, String endTimeStr) {
    // Parse the time strings into DateTime objects
    DateTime startTime = DateFormat("HH:mm:ss").parse(startTimeStr);
    DateTime endTime = DateFormat("HH:mm:ss").parse(endTimeStr);

    // Format them into the desired 12-hour format with lowercase AM/PM
    final DateFormat timeFormatter = DateFormat('h:mma');
    String formattedStartTime = timeFormatter.format(startTime).toLowerCase();
    String formattedEndTime = timeFormatter.format(endTime).toLowerCase();

    return '$formattedStartTime - $formattedEndTime';
  }
}
