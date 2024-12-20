import 'package:flutter/material.dart';

class AppButtonsStyles {
static  ButtonStyle buttonStyle(
      {required double buttonWidth,
      required double buttonHeight,
      required Color primaryColor,
      required Color textColor}) {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(buttonWidth, buttonHeight)),
      backgroundColor: MaterialStateProperty.all(primaryColor),
      foregroundColor: MaterialStateProperty.all(textColor),
    );
  }
}
