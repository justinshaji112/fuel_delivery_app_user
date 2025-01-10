import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/utils/constants/colors.dart';
import 'package:fuel_delivery_app_user/view/theme/button_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldColor,
      primaryColor: AppColors.primaryColor,
      textTheme: GoogleFonts.montserratTextTheme(),
      elevatedButtonTheme:AppButtonTeme.elevatedButtonTheme,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      

      
      
       );

  
}
