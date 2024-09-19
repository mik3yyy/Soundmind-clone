import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';

// Enum to define date picker modes
enum DatePickerMode { birth, license }

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onDateChanged;
  final DatePickerMode mode;
  final String title;

  CustomDatePicker({
    Key? key,
    required this.onDateChanged,
    required this.title,
    this.mode = DatePickerMode.birth, // Default mode is birth
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  // Current year
  final int currentYear = DateTime.now().year;

  // Date components
  int? selectedDay;
  String? selectedMonth;
  int? selectedYear;

  // List of months
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // List of days (1-31)
  List<int> get days => List<int>.generate(31, (index) => index + 1);

  // List of years
  List<int> get years {
    if (widget.mode == DatePickerMode.birth) {
      // Birth mode: Years from the current year down (past 100 years)
      return List<int>.generate(100, (index) => currentYear - index);
    } else {
      // License mode: Years from the current year up (next 100 years)
      return List<int>.generate(100, (index) => currentYear + index);
    }
  }

  // Helper function to get the month number from the month name
  int getMonthNumber(String monthName) {
    return months.indexOf(monthName) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Day Picker
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: context.colors.greyOutline,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: DropdownButton<int>(
                  hint: Text('Day'),
                  value: selectedDay,
                  isExpanded:
                      true, // Make the dropdown fill the container width
                  underline: Container(),
                  items: days.map((int day) {
                    return DropdownMenuItem<int>(
                      value: day,
                      child: Text(day.toString()),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedDay = newValue;
                    });
                    _onDateChanged();
                  },
                ),
              ),
            ),
            Gap(10),

            // Month Picker
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: context.colors.greyOutline,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: DropdownButton<String>(
                  hint: Text('Month'),
                  underline: Container(),
                  isExpanded:
                      true, // Make the dropdown fill the container width
                  value: selectedMonth,
                  items: months.map((String month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue;
                    });
                    _onDateChanged();
                  },
                ),
              ),
            ),
            Gap(10),

            // Year Picker
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: context.colors.greyOutline,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: DropdownButton<int>(
                  hint: Text('Year'),
                  underline: Container(),
                  isExpanded:
                      true, // Make the dropdown fill the container width
                  value: selectedYear,
                  items: years.map((int year) {
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text(year.toString()),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedYear = newValue;
                    });
                    _onDateChanged();
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Method to notify the parent widget about the selected date
  void _onDateChanged() {
    if (selectedDay != null && selectedMonth != null && selectedYear != null) {
      final selectedDate = DateTime(
        selectedYear!,
        getMonthNumber(selectedMonth!),
        selectedDay!,
      );
      widget.onDateChanged(selectedDate);
    }
  }
}
