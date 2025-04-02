import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/auth_cubit/auth_cubit.dart';
import 'package:fuel_delivery_app_user/utils/constants/colors.dart';
import 'package:fuel_delivery_app_user/utils/constants/text_string.dart';
import 'package:fuel_delivery_app_user/view/pages/auth/login_screen.dart';
import 'package:fuel_delivery_app_user/view/routes/route_names.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  void _recendEmail() {
    context.read<AuthCubit>().sendVerificationEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSucess) {
            context.go(RouteNames.home.path);
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
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                      color: AppColors.black, shape: BoxShape.circle),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppStrings.verifyEmailTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Text(
                  AppStrings.verfyEmaildescription,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: _recendEmail,
                    child: const Text(AppStrings.resendEmail)),
                const SizedBox(height: 8 + 2),
                TextButton(
                    onPressed: () {
                      context.go(RouteNames.signIn.path);
                    },
                    child: const Text(AppStrings.goBackButton)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
