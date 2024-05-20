// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/widgets/decorations/input_deconrations.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/app/constants/size.dart';

class MyTextField extends StatelessWidget {
  FocusNode focusNode;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData prfixIcon;
  final String hintText;
  final String lableText;
  final double textFieldWidth =
      AppSize.textFeeldWidth; // Assuming AppSize is defined elsewhere
  final double textFieldHeight = AppSize.textFeeldHeight;
  final Color borderColor = ColorPellet.textfeeldBorderColor;

  final Color primaryColor = ColorPellet.primaryColor;
  // final EdgeInsets contentPadding =
  //     const EdgeInsets.only(left: 20); // Adjust based on icon size
  MyTextField({
    required this.focusNode,
    super.key,
    required this.validator,
    required this.controller,
    required this.hintText,
    required this.lableText,
    required this.prfixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      validator: validator,
      decoration: AppInputDeconration.emailFieldDecoration(
          prifixIcon: prfixIcon,
          hintText: hintText,
          lableText: lableText,
          focusBorderColor: ColorPellet.primaryColor),
    );
  }
}
