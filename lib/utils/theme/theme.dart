import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/utils/constants/size.dart';
import 'package:fuel_delivery_app_user/utils/theme/custom_thmes/checkbox_theme.dart';
import 'package:fuel_delivery_app_user/utils/theme/custom_thmes/custom_input_theme.dart';
import 'package:fuel_delivery_app_user/utils/theme/custom_thmes/custom_text_theme.dart';
import 'package:fuel_delivery_app_user/utils/theme/custom_thmes/button_thme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = FlexThemeData.light(
    scheme: FlexScheme.blackWhite,
    useMaterial3: true,
    textTheme: CTextThme.textTheme,
    fontFamily: GoogleFonts.montserrat().fontFamily,
  ).copyWith(
    inputDecorationTheme: CInputDecorationThme.inputDecorationTheme,
    checkboxTheme:AppCheckboxTheme.themeData,
    textButtonTheme: AppButtonTheme.textButton,
    elevatedButtonTheme: AppButtonTheme.elevatedButton,
    outlinedButtonTheme: AppButtonTheme.outlinedButton,
  );
}
