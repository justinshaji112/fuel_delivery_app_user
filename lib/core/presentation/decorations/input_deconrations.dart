import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuel_delivery_app_user/core/presentation/decorations/imput_border/inputBorders.dart';
import 'package:fuel_delivery_app_user/app/constants/size.dart';

class AppInputDeconration {
  static InputDecoration emailFieldDecoration({
    required Color focusBorderColor,
    required String hintText,
    required String lableText,
    IconData? prifixIcon,
  }) {
    return InputDecoration(
      constraints: BoxConstraints(
          minHeight: AppSize.textFeeldHeight,
          maxHeight: AppSize.textFeeldMaxHight,
          maxWidth: AppSize.textFeeldWidth),
      hintText: hintText,
      label: Text(lableText),
      enabledBorder: AppInputBorders.enableborder,
      focusedBorder: AppInputBorders.focusBorder,
      errorBorder: AppInputBorders.errorBorder,
    
      focusColor: focusBorderColor,
      prefixIcon: Icon(prifixIcon),
      contentPadding: EdgeInsets.only(left: AppSize.gap10),
    );
  }
}
