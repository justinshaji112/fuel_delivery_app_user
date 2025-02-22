import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/utils/validators/text_validators.dart';

class PassWordField extends StatefulWidget {
  final TextEditingController passwordController;
  bool isConfirmePassWord;
  TextEditingController? originalpasswordController;
  PassWordField(
      {super.key,
      required this.passwordController,
      this.isConfirmePassWord = false,
      this.originalpasswordController});

  @override
  State<StatefulWidget> createState() => _PassWordFieldState();
}

class _PassWordFieldState extends State<PassWordField> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline),
        labelText: 'Password',
        hintText: 'Enter your password',
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: widget.isConfirmePassWord
          ? (value) => AppTextValidator.confirmPasswordValidator(
              value, widget.originalpasswordController?.text)
          : AppTextValidator.passwordValidator,
    );
  }
}
