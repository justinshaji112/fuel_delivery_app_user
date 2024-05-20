// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:fuel_delivery_app_user/widgets/imput_border/inputBorders.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/app/constants/size.dart';

// ignore: must_be_immutable
class PassWordFeeld extends StatefulWidget {
  final String lableText;
  final String hintText;
  FocusNode focusNode;

  final String? Function(String?)? validator;
  final TextEditingController controller;
  PassWordFeeld({
    required this.focusNode,
    required this.hintText,
    required this.lableText,
    required this.validator,
    required this.controller,
  });

  @override
  State<PassWordFeeld> createState() => _PassWordFeeldState();
}

class _PassWordFeeldState extends State<PassWordFeeld> {
  bool _isPasswordVisible = false;

  // Assuming AppSize is defined elsewhere

  final Color borderColor = ColorPellet.textfeeldBorderColor;

  final Color primaryColor = ColorPellet.primaryColor;

  final EdgeInsets contentPadding = const EdgeInsets.only(left: 20);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
          constraints: BoxConstraints(
              minHeight: AppSize.textFeeldHeight,
              maxHeight: AppSize.textFeeldMaxHight,
              maxWidth: AppSize.textFeeldWidth),
          hintText: widget.hintText,
          label: Text(widget.lableText),
          enabledBorder: AppInputBorders.enableborder,
          focusedBorder: AppInputBorders.focusBorder,
          errorBorder: AppInputBorders.errorBorder,
          focusColor: ColorPellet.primaryColor,
          prefixIcon: const Icon(Icons.lock_outline),
          contentPadding: EdgeInsets.only(left: AppSize.gap10),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            child: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility),
          )),

// InputDecoration(
//       constraints: BoxConstraints(
//           minHeight: AppSize.textFeeldHeight,
//           maxHeight: AppSize.textFeeldMaxHight,
//           maxWidth: AppSize.textFeeldWidth),
//       hintText: hintText,
//       label: Text(lableText),
//       enabledBorder: AppInputBorders.enableborder,
//       focusedBorder: AppInputBorders.focusBorder,
//       errorBorder: AppInputBorders.errorBorder,
//       focusColor: focusBorderColor,
//       prefixIcon: Icon(prifixIcon),
//       contentPadding: EdgeInsets.only(left: AppSize.gap10),
//     );
    );
  }
}
