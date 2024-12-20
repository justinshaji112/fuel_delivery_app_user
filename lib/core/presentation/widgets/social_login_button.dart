import 'package:flutter/material.dart';

import 'package:fuel_delivery_app_user/app/constants/size.dart';

class SocialLoginButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? iconUrl;
  final String text;

  const SocialLoginButton({
    super.key,
    required this.onPressed,
    required this.iconUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Adjust the radius here
        ),
        maximumSize: Size(AppSize.buttonWidth, AppSize.buttonHeight),
        backgroundColor: const Color(0xFFEDEEF0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (iconUrl != null)
            Image.asset(
              iconUrl!,
              width: 30,
              height: 30,
            )
          else
            const SizedBox(
              width: 30,
            ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          const Icon(
            Icons.abc,
            size: 50,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
