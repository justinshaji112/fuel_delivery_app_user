import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/core/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/core/auth/presentation/widgets/snake_error_bar.dart';
import 'package:fuel_delivery_app_user/extentions.dart';
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

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../auth/presentation/validators/text_validators.dart';


class SingInPage extends StatelessWidget {
  SingInPage({super.key});
  static final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  ErrorSnakeBar.showSnakeBar(context: context, err: state.err);
                }
              },
              child: Column(
                children: <Widget>[
                  Lottie.asset(AppLottie.loginAnimation),
                  MyTextField(
                    focusNode: emailFocusNode,
                    prfixIcon: Icons.email_outlined,
                    hintText: context.loc.email_hint,
                    lableText: context.loc.email,
                    validator: TextValidators.isPasswordValid,
                    controller: emailController,
                  ),
                  const Gap(AppSize.gap20),
                  PasswordField(
                    focusNode: passwordFocusNode,
                    hintText: context.loc.password_hint,
                    lableText: context.loc.password,
                    validator: TextValidators.isPasswordValid,
                    controller: passwordController,
                  ),
                  const Gap(AppSize.gap20),
                  PrimaryButton(
                    buttonFunction: () {
                      authBloc.add(LoginButtonPressedEvent(
                        email: emailController.text,
                        password: passwordController.text,
                      ));
                    },
                    backgroundColor: ColorPellet.primaryColor,
                    textColor: ColorPellet.white,
                    buttonText: context.loc.login,
                  ),
                  const Gap(AppSize.gap20),
                  const Gap(AppSize.gap10),
                  SignUpOrLoginText(
                    buttonText: context.loc.sing_up,
                    prefixText: context.loc.dont_have_an_account,
                    onTap: () {
                      context.goNamed(RouteNames.singUp.name);
                    },
                  ),
                  const Gap(AppSize.gap20),
                  SocialLoginButton(
                    onPressed: () {
                      authBloc.add(GoogleSingInEvent());
                    },
                    text: context.loc.sign_up_with_google,
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
