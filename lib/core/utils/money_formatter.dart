import 'package:intl/intl.dart';

class MoneyFormatter {
  static String doubleToMoney(int value) {
    // Create a NumberFormat for the locale that uses comma as thousand separator and dot as decimal separator
    final formatter =
        NumberFormat.currency(locale: 'en_US', symbol: '', decimalDigits: 2);

    // Format the double value to money format
    return formatter.format(value);
  }
}
