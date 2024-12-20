import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/app/constants/size.dart';
import 'package:fuel_delivery_app_user/app/constants/app_fonts.dart';
import 'package:fuel_delivery_app_user/core/presentation/styles/button_styles.dart';

class PrimaryButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String buttonText;

  final VoidCallback buttonFunction;
  PrimaryButton(
      {required this.buttonFunction,
      required this.backgroundColor,
      required this.textColor,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: AppButtonsStyles.buttonStyle(
          buttonWidth: AppSize.buttonWidth,
          buttonHeight: AppSize.buttonHeight,
          primaryColor: backgroundColor,
          textColor: textColor),
      onPressed: buttonFunction,
      child: Text(
        buttonText,
        style: TextStyle(
            fontFamily: AppFonts.inter_var), // Assuming 'Inter Var' is a valid font family name
      ),
    );
  }
}
