import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/routes/route_names.dart';

import 'package:fuel_delivery_app_user/widgets/buttons.dart';
import 'package:fuel_delivery_app_user/widgets/hava_an_accont_text.dart';
import 'package:fuel_delivery_app_user/widgets/password_feald.dart';
import 'package:fuel_delivery_app_user/widgets/phone_feild.dart';
import 'package:fuel_delivery_app_user/widgets/text_feeds.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/app/constants/lottie_animatios.dart';
import 'package:fuel_delivery_app_user/app/constants/size.dart';
import 'package:fuel_delivery_app_user/core/validators/text_validators.dart';
import 'package:fuel_delivery_app_user/features/auth/data/models/auth_model.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/pages/validate_email.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/widgets/snake_error_bar.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passWordController =
      TextEditingController();
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController phoneNuberController =
      TextEditingController();

  // Move FocusNodes outside of the build method
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SingnUpFaildState) {
          ErrorSankeBar.showSnakeBar(context: context, err: state.err);
        } else if (state is SignUpSucessState) {
          context.goNamed(RouteNames.validateEmail.name);
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: formKey,
            child: Column(
              children: <Widget>[
                Lottie.asset(AppLotti.loginAnimation),
                MyTextField(
                  prfixIcon: Icons.person,
                  hintText: "Enter Your Name",
                  lableText: "Name",
                  validator: TextValidators.isNameValid,
                  controller: nameController,
                  focusNode: nameFocusNode, // Use the FocusNode here
                ),
                Gap(AppSize.gap20),
                PhoneNumberFeild(
                    controller: phoneNuberController,
                    focusNode:
                        phoneFocusNode), // Assuming PhoneNumberFeild accepts a FocusNode
                Gap(AppSize.gap20),
                MyTextField(
                  prfixIcon: Icons.email_outlined,
                  hintText: "Enter Your Email",
                  lableText: "Email",
                  validator: TextValidators.isEmailValid,
                  controller: emailController,
                  focusNode: emailFocusNode, // Use the FocusNode here
                ),
                Gap(AppSize.gap20),
                PassWordFeeld(
                  hintText: 'Enter your password',
                  lableText: 'Password',
                  validator: TextValidators.isPasswordValid,
                  controller: passWordController,
                  focusNode: passwordFocusNode, // Use the FocusNode here
                ),
                Gap(AppSize.gap20),
                PrimaryButton(
                    buttonFunction: () {
                      if (formKey.currentState!.validate()) {}
                      authBloc.add(SingUpButtonPressedEvent(
                          user: UserModel(
                              email: emailController.text,
                              password: passWordController.text,
                              phoneNumber: phoneNuberController.text,
                              name: nameController.text)));
                    },
                    backgroundColor: ColorPellet.primaryColor,
                    textColor: ColorPellet.white,
                    buttonText: "Sign Up"),
                                Gap(AppSize.gap10),
                Gap(AppSize.gap20),
                Gap(AppSize.gap10),
                SingUpOrLoginText(
                    buttonText: "Login",
                    prefixText: "Already have an account?   ",
                    onTap: () {
                      context.goNamed(RouteNames.signIn.name);
                    }),
                Gap(AppSize.gap20),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
