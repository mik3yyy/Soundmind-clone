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

  static String formatTimeRange(String startTimeStr, String endTimeStr) {
    // Parse the time strings into DateTime objects
    DateTime startTime = DateFormat("HH:mm:ss").parse(startTimeStr);
    DateTime endTime = DateFormat("HH:mm:ss").parse(endTimeStr);

    // Format them into the desired 12-hour format with lowercase AM/PM
    final DateFormat timeFormatter = DateFormat('h:mma');
    String formattedStartTime = timeFormatter.format(startTime).toLowerCase();
    String formattedEndTime = timeFormatter.format(endTime).toLowerCase();

    return '$formattedStartTime - $formattedEndTime';
  }

  static String formatDateTime(DateTime dateTime) {
    // Get the day of the month
    int day = dateTime.day;

    // Determine the suffix for the day
    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    // Format the date string
    String formattedDate = DateFormat('EEE, d').format(dateTime) +
        suffix +
        DateFormat(' MMM yyyy').format(dateTime);
    return formattedDate;
  }
}
