import 'package:flutter/material.dart';

class CustomAppDialogs {
  /// Basic Alert Dialog
  static void showAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  /// Confirmation Dialog
  static Future<bool> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    bool result = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              result = false;
              Navigator.pop(context);
            },
            child: Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              result = true;
              Navigator.pop(context);
            },
            child: Text("Confirm", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
    return result;
  }

  /// Loading Dialog
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  /// Success Dialog
  static void showSuccessDialog({required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Error Dialog
  static void showErrorDialog({required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
