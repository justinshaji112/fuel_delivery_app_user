import 'package:flutter/material.dart';

class AppLoader{
  static void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }



  static void hideLoader(BuildContext context) {
    Navigator.of(context).pop();
  }


  static void showLoaderWithMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 10),
              Text(message),
            ],
          ),
        );
      },
    );
  }
}