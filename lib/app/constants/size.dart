import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize {
  static width(context) => MediaQuery.of(context).size.width;
  static  hight(context) => MediaQuery.of(context).size.height;
  static  double buttonWidth = 330.w;
  static const double buttonHeight = 45;
  static  double textFeeldWidth = 330.w;
  static const double textFeeldHeight = 45;
  static const double phoneFeildHeigh = 65;
  static const double textFeeldMaxHight = 70;

  static const double gap10 = 10;
  static const double gap20 = 20;
}
