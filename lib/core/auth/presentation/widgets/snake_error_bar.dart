import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';

class ErrorSnakeBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnakeBar(
      {required BuildContext context, required String err}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        err.toString(),
      ),
      backgroundColor: ColorPellet.primaryColor,
    ));
  }
}
