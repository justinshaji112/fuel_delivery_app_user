import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/widgets/decorations/input_deconrations.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/core/validators/text_validators.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberFeild extends StatelessWidget {
  final TextEditingController controller;
 final FocusNode focusNode;

 const PhoneNumberFeild(
      {super.key, required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      
      validator: TextValidators.isPhoneNuberValid,
      focusNode: focusNode,
      controller: controller,
      decoration: AppInputDeconration.emailFieldDecoration(
        focusBorderColor: ColorPellet.primaryColor,
        hintText: "Phone nuber",
        lableText: "Phone",
      ),
      initialCountryCode: 'IN',
      onChanged: (phone) {},
      showCountryFlag: false,
    );
  }
}
