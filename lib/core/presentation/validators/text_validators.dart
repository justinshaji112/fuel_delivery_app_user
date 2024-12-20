import 'package:intl_phone_field/phone_number.dart';

class TextValidators {
  static String? isNameValid(String? text) {
    // Improved regex to allow for optional spaces and starts with either a capital or lowercase letter
    final RegExp namePattern = RegExp(r"^[A-Za-z][A-Za-z ]*$");

    if (text != null && namePattern.hasMatch(text)) {
      return null; // Valid name
    } else {
      return "Name is not valid. It should start with a letter and may contain spaces.";
    }
  }

  static String? isEmailValid(String? text) {
    if (text != null && text.contains("@") && text.contains(".")) {
      return null;
    } else {
      return "Email in not valid";
    }
  }

  static String? isPasswordValid(String? text) {
    if (text != null && text.length > 6) {
      return null;
    } else {
      return "Password must start with three lowercase letters followed by three digits.";
    }
  }

  static Future<String?> isPhoneNuberValid(PhoneNumber? text) async {
    if (text != null && text.number.contains(RegExp(r"{3}[0-9]{3}"))) {
      return null;
    } else {
      return "Password in not valid";
    }
  }
}
