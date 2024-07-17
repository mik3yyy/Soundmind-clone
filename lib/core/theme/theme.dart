library theme;

import 'package:flutter/material.dart';

part 'colors.dart';
part 'text_styles.dart';
part 'app_colors.dart';

ThemeData get appTheme => _buildLightTheme();
ThemeData get darkTheme => _buildDarkTheme();

ThemeData _buildLightTheme() {
  const Color primaryColor = _Colors.primaryColor;
  const Color secondaryColor = _Colors.secondaryColor;

  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    error: _Colors.red,
  );

  final themeData = ThemeData(
    useMaterial3: false,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: _Colors.scaffoldColor,
    cardColor: _Colors.white,
    colorScheme: colorScheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: _Colors.scaffoldColor,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: _Colors.black,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      contentTextStyle: _AppTextStyles.bodyMedium,
      insetPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
        minimumSize: const Size(double.infinity, 55),
        backgroundColor: _Colors.primaryColor,
        textStyle: _AppTextStyles.displayMedium.copyWith(color: _Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _AppTextStyles.displayMedium.copyWith(
          color: _Colors.primaryColor,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
        minimumSize: const Size(double.infinity, 55),
        backgroundColor: _Colors.white,
        foregroundColor: _Colors.primaryColor,
        side: BorderSide.none,
        textStyle: _AppTextStyles.displayMedium.copyWith(
          color: _Colors.primaryColor,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _Colors.greyOutline),
      ),
      isDense: true,
      filled: true,
      fillColor: _Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: _AppTextStyles.bodyLarge,
      bodyMedium: _AppTextStyles.bodyMedium, // default text styling
      bodySmall: _AppTextStyles.bodySmall,
      displayLarge: _AppTextStyles.displayLarge,
      displayMedium: _AppTextStyles.displayMedium,
      titleLarge: _AppTextStyles.titleLarge,
      titleMedium: _AppTextStyles.titleMedium,
      titleSmall: _AppTextStyles.titleSmall,
      labelSmall: _AppTextStyles.labelSmall,
    ),
    extensions: [
      AppColorExtension(
        green: _Colors.green,
        white: _Colors.white,
        red: _Colors.red,
        orange: _Colors.orange,
        captionGrey: _Colors.captionColor,
        black: _Colors.black,
        borderGrey: _Colors.greyLight,
        blueDecor: _Colors.blueDecor,
        greenDecor: _Colors.greenDecor,
        greyDecor: _Colors.greyDecor,
        orangeDecor: _Colors.orangeDecor,
        pinkDecor: _Colors.pinkDecor,
        purpleDecor: _Colors.purpleDecor,
        blueDecorDark: _Colors.blueDecorDark,
        greenDecorDark: _Colors.greenDecorDark,
        greyDecorDark: _Colors.greyDecorDark,
        orangeDecorDark: _Colors.orangeDecorDark,
        pinkDecorDark: _Colors.pinkDecorDark,
        purpleDecorDark: _Colors.purpleDecorDark,
        greyOutline: _Colors.greyOutline,
      ),
    ],
  );
  return themeData;
}

ThemeData _buildDarkTheme() {
  const Color primaryColor = _Colors.primaryColor;
  const Color secondaryColor = _Colors.secondaryColor;

  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    error: _Colors.red,
  );

  final themeData = ThemeData(
    useMaterial3: false,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: _Colors.scaffoldColor,
    cardColor: _Colors.white,
    colorScheme: colorScheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: _Colors.scaffoldColor,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: _Colors.black,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      contentTextStyle: _AppTextStyles.bodyMedium,
      insetPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
        minimumSize: const Size(double.infinity, 55),
        backgroundColor: _Colors.primaryColor,
        textStyle: _AppTextStyles.displayMedium.copyWith(color: _Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _AppTextStyles.displayMedium.copyWith(
          color: _Colors.primaryColor,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
        minimumSize: const Size(double.infinity, 55),
        backgroundColor: _Colors.white,
        foregroundColor: _Colors.primaryColor,
        side: BorderSide.none,
        textStyle: _AppTextStyles.displayMedium.copyWith(
          color: _Colors.primaryColor,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _Colors.greyOutline),
      ),
      isDense: true,
      filled: true,
      fillColor: _Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: _AppTextStyles.bodyLarge,
      bodyMedium: _AppTextStyles.bodyMedium, // default text styling
      bodySmall: _AppTextStyles.bodySmall,
      displayLarge: _AppTextStyles.displayLarge,
      displayMedium: _AppTextStyles.displayMedium,
      titleLarge: _AppTextStyles.titleLarge,
      titleMedium: _AppTextStyles.titleMedium,
      titleSmall: _AppTextStyles.titleSmall,
      labelSmall: _AppTextStyles.labelSmall,
    ),
    extensions: [
      AppColorExtension(
        green: _Colors.green,
        white: _Colors.white,
        red: _Colors.red,
        orange: _Colors.orange,
        captionGrey: _Colors.captionColor,
        black: _Colors.black,
        borderGrey: _Colors.greyLight,
        blueDecor: _Colors.blueDecor,
        greenDecor: _Colors.greenDecor,
        greyDecor: _Colors.greyDecor,
        orangeDecor: _Colors.orangeDecor,
        pinkDecor: _Colors.pinkDecor,
        purpleDecor: _Colors.purpleDecor,
        blueDecorDark: _Colors.blueDecorDark,
        greenDecorDark: _Colors.greenDecorDark,
        greyDecorDark: _Colors.greyDecorDark,
        orangeDecorDark: _Colors.orangeDecorDark,
        pinkDecorDark: _Colors.pinkDecorDark,
        purpleDecorDark: _Colors.purpleDecorDark,
        greyOutline: _Colors.greyOutline,
      ),
    ],
  );
  return themeData;
}
