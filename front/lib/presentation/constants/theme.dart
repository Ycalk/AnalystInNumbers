import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    scrollbarTheme: ScrollbarThemeData(
      thumbVisibility: WidgetStateProperty.all(false),
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.tertiary,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
      titleTextStyle: GoogleFonts.montserrat(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: AppColors.title,
      ),
      iconTheme: const IconThemeData(color: AppColors.title),
    ),
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.primary,
      primary: AppColors.primary,
      onPrimary: AppColors.tertiary
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.tertiary,
      selectionHandleColor: AppColors.tertiary,
      selectionColor: Colors.black26,
    ),
    checkboxTheme: const CheckboxThemeData(
      shape: CircleBorder(),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple,
    ),
  );
}
