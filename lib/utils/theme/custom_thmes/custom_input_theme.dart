import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/utils/constants/colors.dart';
import 'package:fuel_delivery_app_user/utils/constants/size.dart';
import 'package:google_fonts/google_fonts.dart';

class CInputDecorationThme {
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: GoogleFonts.montserrat(
      color: AppColors.black,
    ),
    hintStyle: GoogleFonts.montserrat(
      fontSize: AppSizes.defaultTextSize,
      color: Colors.black38,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.textFieldBorderRadius),
      borderSide: const BorderSide(
        color: AppColors.inputBorder,
        width: AppSizes.defaulttextFieldBorderWidth,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.textFieldBorderRadius),
      borderSide: const BorderSide(
        color: AppColors.inputFocused,
        width: AppSizes.focusedTextFieldBorderWidth,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.textFieldBorderRadius),
      borderSide: const BorderSide(
        color: AppColors.inputError,
        width: AppSizes.defaulttextFieldBorderWidth,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.textFieldBorderRadius),
      borderSide: const BorderSide(
        color: AppColors.inputError,
        width: AppSizes.focusedTextFieldBorderWidth,
      ),
    ),
  );
}
