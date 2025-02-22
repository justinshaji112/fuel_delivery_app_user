import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/utils/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CTextThme {
  static TextTheme textTheme = GoogleFonts.montserratTextTheme(
    const TextTheme(
      displayLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.black87),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
    ),
  );
}
