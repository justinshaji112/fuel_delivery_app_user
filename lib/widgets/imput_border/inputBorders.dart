import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';

class AppInputBorders {
  static InputBorder enableborder = OutlineInputBorder(
    borderSide: BorderSide(color: ColorPellet.textfeeldBorderColor),
  );
  static InputBorder focusBorder = OutlineInputBorder(
    borderSide: BorderSide(color: ColorPellet.primaryColor, width: 2),
    borderRadius: BorderRadius.circular(10),
  );
  static InputBorder errorBorder = OutlineInputBorder(
    
    borderSide: BorderSide(color: ColorPellet.errorColor, width: 2, ),
    borderRadius: BorderRadius.circular(10),
  );
}
