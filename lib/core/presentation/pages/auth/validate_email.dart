import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/core/data/models/auth_model.dart';
import 'package:fuel_delivery_app_user/core/presentation/routes/route_names.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/buttons.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/snake_error_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ValidateEmail extends StatelessWidget {
   ValidateEmail({super.key, });


  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is EmailVaryfiedState) {
              context.goNamed(RouteNames.home.name);
            }

            if (state is EmailVarificationFailedState) {
              ErrorSnakeBar.showSnakeBar(
                  context: context, err: "Varification Failed");
            }
          },
          builder: (context, state) {
            return Column(
              children: <Widget>[
                Lottie.asset("assets/animations/emial.json"),
                TextButton(
                    onPressed: () {
                      authBloc.add(LogoutPressedEvent());
                    },
                    child: Text(
                      "Resend Otp",
                      style: TextStyle(color: ColorPellet.primaryColor),
                    )),
                PrimaryButton(
                    buttonFunction: () {
                      authBloc.add(VerifyButtonPressedEvent());
                    },
                    backgroundColor: ColorPellet.primaryColor,
                    textColor: ColorPellet.white,
                    buttonText: "Check veryfied")
              ],
            );
          },
        ),
      ),
    );
  }
}
