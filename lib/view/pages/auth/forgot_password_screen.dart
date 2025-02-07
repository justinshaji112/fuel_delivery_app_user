import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/cubit/auth_cubit.dart';
import 'package:fuel_delivery_app_user/utils/constants/colors.dart';
import 'package:fuel_delivery_app_user/view/pages/auth/login_screen.dart';
import 'package:fuel_delivery_app_user/view/routes/route_names.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

//on pressed of TextButton Go back
  void _goBackButtionPressed() {
    context.go(RouteNames.signIn.path);
  }

  //on pressed of ElevatedButton Send

  void _sendEmailButtonPressed() {
    context.read<AuthCubit>().resetPassword(emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          log(state.toString());

          if (state is PasswordResetEmailSent) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Email Sent!"),
                  content: const Text(
                      "Please check your email to reset your password"),
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        context.go(RouteNames.signIn.path);
                      },
                    ),
                  ],
                );
              },
            );
          }

          if (state is AuthLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sending Email..."),
                      CircularProgressIndicator(),
                      Text("Please Wait"),
                    ],
                  ),
                );
              },
            );
          }

          if (state is AuthFaild) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                  child: const Center(
                      child: Icon(Icons.lock, color: Colors.white, size: 50)),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "We will send you a link to reset your password",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: "Enter your email",
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_outlined)),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: _sendEmailButtonPressed,
                    child: const Text("Send")),
                const SizedBox(height: 24),
                TextButton(
                    onPressed: _goBackButtionPressed,
                    child: const Text("Go back"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
