class DateFormater {
  static String formatDate(DateTime dateTime) {
    final year = dateTime.year;
    final month =
        dateTime.month.toString().padLeft(2, '0'); // Ensures two-digit month
    final day =
        dateTime.day.toString().padLeft(2, '0'); // Ensures two-digit day

    return '$year-$month-$day';
  }
}
