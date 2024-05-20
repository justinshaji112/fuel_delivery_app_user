import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';

class SingUpOrLoginText extends StatelessWidget {
 final String prefixText;
 final String buttonText;
 final void Function() onTap;
  SingUpOrLoginText(
      {super.key,
      required this.onTap,
      required this.buttonText,
      required this.prefixText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prefixText),
        GestureDetector(
          onTap: onTap,
          child: Text(
            buttonText,
            style: TextStyle(
                color: ColorPellet.primaryColor, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
