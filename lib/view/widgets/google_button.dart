import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/utils/constants/images.dart';
import 'package:fuel_delivery_app_user/utils/constants/text_string.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GoogleButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageUrls.googleIcon,
            height: 24,
            width: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            AppStrings.loginWithGoogle,
          )
        ],
      ),
    );
  }
}