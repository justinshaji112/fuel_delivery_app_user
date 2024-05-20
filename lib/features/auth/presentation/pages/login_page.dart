import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/routes/route_names.dart';
import 'package:fuel_delivery_app_user/widgets/buttons.dart';
import 'package:fuel_delivery_app_user/widgets/hava_an_accont_text.dart';
import 'package:fuel_delivery_app_user/widgets/password_feald.dart';
import 'package:fuel_delivery_app_user/widgets/social_login_button.dart';
import 'package:fuel_delivery_app_user/widgets/text_feeds.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/app/constants/images.dart';
import 'package:fuel_delivery_app_user/app/constants/lottie_animatios.dart';
import 'package:fuel_delivery_app_user/app/constants/size.dart';
import 'package:fuel_delivery_app_user/core/validators/text_validators.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/pages/signup.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/widgets/snake_error_bar.dart';
import 'package:fuel_delivery_app_user/features/home/presentation/screen_home.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../bloc/bloc/auth_bloc.dart';

class SingInPage extends StatelessWidget {
  SingInPage({super.key});
  static final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LoginState) {
                  context.goNamed(RouteNames.home.name);
                } else if (state is LoginErrorState) {
                  print('the error is ${state.err}');
                  ErrorSankeBar.showSnakeBar(context: context, err: state.err);
                }
              },
              child: Column(
                children: <Widget>[
                  Lottie.asset(AppLotti.loginAnimation),
                  MyTextField(
                    focusNode: emailFocusNode,
                    prfixIcon: Icons.email_outlined,
                    hintText: "Enter Your Email",
                    lableText: "Email",
                    validator: TextValidators.isPasswordValid,
                    controller: emailController,
                  ),
                  Gap(AppSize.gap20),
                  PassWordFeeld(
                    focusNode: passwordFocusNode,
                    hintText: 'Enter your password',
                    lableText: 'Password',
                    validator: TextValidators.isPasswordValid,
                    controller: passWordController,
                  ),
                  Gap(AppSize.gap20),
                  PrimaryButton(
                    buttonFunction: () {
                      authBloc.add(LoginButtonPressedEvent(
                        email: emailController.text,
                        password: passWordController.text,
                      ));
                    },
                    backgroundColor: ColorPellet.primaryColor,
                    textColor: ColorPellet.white,
                    buttonText: "Login",
                  ),
                  Gap(AppSize.gap20),
                  Gap(AppSize.gap10),
                  SingUpOrLoginText(
                    buttonText: "Sign up",
                    prefixText: "Don't have an Account?  ",
                    onTap: () {
                      context.goNamed(RouteNames.singUp.name);
                    },
                  ),
                  Gap(AppSize.gap20),
                  SocialLoginButton(
                    onPressed: () {
                      authBloc.add(GoogleSingInEvent());
                    },
                    text: "Login with Google",
                    iconUrl: ImageUrls.googleIcon,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
