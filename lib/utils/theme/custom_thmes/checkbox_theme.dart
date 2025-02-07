import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/utils/constants/size.dart';

class AppCheckboxTheme {
  static CheckboxThemeData themeData = CheckboxThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.defaultCheckBoxBorderRadius),
    ),
  );
}
