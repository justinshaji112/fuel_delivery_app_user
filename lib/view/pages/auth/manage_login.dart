import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/cubit/auth_cubit.dart';
import 'package:fuel_delivery_app_user/view/pages/auth/login_screen.dart';
import 'package:fuel_delivery_app_user/view/pages/auth/verify_email_screen.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/home.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/screen_home.dart';

/*
this screen is used to manage the login and signup screen
it will check if the user is logged in or not and will show the home screen or login screen
if the user is logged in it will show the home screen
if the user is not logged in it will show the login screen
*/
class LoginManager extends StatelessWidget {
  const LoginManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        print(state.toString());

        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return state is AuthSucess ? const HomeScreen() : state is EmailVrification ? const VerifyEmailScreen():  const LoginPage();
      },
    );
  }
}
