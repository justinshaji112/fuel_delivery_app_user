import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/utils/constants/colors.dart';
import 'package:fuel_delivery_app_user/utils/constants/size.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButtonTheme {
  AppButtonTheme._();
  static ElevatedButtonThemeData elevatedButton = ElevatedButtonThemeData(
      style: ButtonStyle(
          alignment: Alignment.center,
          minimumSize: WidgetStateProperty.all(
            Size(AppSizes.defaultButtionWidth, AppSizes.defaultButtionHeight),
          ),
          foregroundColor: const WidgetStatePropertyAll(AppColors.secondary),
          backgroundColor: const WidgetStatePropertyAll(Colors.black),
          padding:
              const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppSizes.defaultButtonBorderRadius),
          )),
          elevation: const WidgetStatePropertyAll(2),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: AppSizes.defaultFontSize,
              fontWeight: FontWeight.w600,
            ),
          )));

  static TextButtonThemeData textButton = TextButtonThemeData(
      style: TextButton.styleFrom(
          textStyle: GoogleFonts.montserrat(
            color: AppColors.info,
            fontWeight: FontWeight.w600,
          ),
          foregroundColor: AppColors.info,
          splashFactory: NoSplash.splashFactory));
  static OutlinedButtonThemeData outlinedButton = OutlinedButtonThemeData(
      style: ButtonStyle(
    alignment: Alignment.center,
    elevation: const WidgetStatePropertyAll(0),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.defaultButtonBorderRadius),
      ),
    ),
    minimumSize: WidgetStatePropertyAll(
        Size(AppSizes.defaultButtionWidth, AppSizes.defaultButtionHeight)),
  ));
}
