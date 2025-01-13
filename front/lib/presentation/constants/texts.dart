import 'package:flutter/material.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Texts {
  static const String appName = 'Analyst In Numbers';
  static const String errorMessage = 'Что-то пошло не так';
}

class TextStyles {
  static final TextStyle title = GoogleFonts.montserrat(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: AppColors.title,
  );

  static final TextStyle subtitle = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: AppColors.title,
  );

  static final TextStyle description = GoogleFonts.montserrat(
    fontSize: 14,
    color: AppColors.description,
  );
}
