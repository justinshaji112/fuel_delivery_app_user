import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/utils/constants/colors.dart';

class AppButtonTeme {
  AppButtonTeme._();
  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.black,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
}
