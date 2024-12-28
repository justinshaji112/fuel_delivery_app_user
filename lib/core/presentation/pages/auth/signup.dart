import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/extentions.dart';
import 'package:fuel_delivery_app_user/core/presentation/routes/route_names.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/buttons.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/hava_an_accont_text.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/password_feald.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/phone_feild.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/text_feeds.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/app/constants/lottie_animatios.dart';
import 'package:fuel_delivery_app_user/app/constants/size.dart';
import 'package:fuel_delivery_app_user/core/presentation/validators/text_validators.dart';
import 'package:fuel_delivery_app_user/core/data/models/auth_model.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/snake_error_bar.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    phoneFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SingnUpFaildState) {
            ErrorSnakeBar.showSnakeBar(context: context, err: state.err);
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
                  Lottie.asset(AppLottie.loginAnimation),
                  MyTextField(
                    prfixIcon: Icons.person,
                    hintText: context.loc.name_hint,
                    lableText: context.loc.name,
                    validator: TextValidators.isNameValid,
                    controller: nameController,
                    focusNode: nameFocusNode, // Use the FocusNode here
                  ),
                  const Gap(AppSize.gap20),
                  PhoneNumberFeild(
                    controller: phoneNumberController,
                    focusNode:
                        phoneFocusNode, // Assuming PhoneNumberFeild accepts a FocusNode
                  ),
                  const Gap(AppSize.gap20),
                  MyTextField(
                    prfixIcon: Icons.email_outlined,
                    hintText: context.loc.email_hint,
                    lableText: context.loc.email,
                    validator: TextValidators.isEmailValid,
                    controller: emailController,
                    focusNode: emailFocusNode, // Use the FocusNode here
                  ),
                  const Gap(AppSize.gap20),
                  PasswordField(
                    hintText: context.loc.password_hint,
                    lableText: context.loc.password,
                    validator: TextValidators.isPasswordValid,
                    controller: passwordController,
                    focusNode: passwordFocusNode, // Use the FocusNode here
                  ),
                  const Gap(AppSize.gap20),
                  PrimaryButton(
                    buttonFunction: () {
                      if (formKey.currentState!.validate()) {
                        authBloc.add(SignUpButtonPressedEvent(
                          user: UserModel(
                            email: emailController.text,
                            password: passwordController.text,
                            phoneNumber: phoneNumberController.text,
                            name: nameController.text,
                          ),
                        ));
                      }
                    },
                    backgroundColor: ColorPellet.primaryColor,
                    textColor: ColorPellet.white,
                    buttonText: context.loc.sing_up,
                  ),
                  const Gap(AppSize.gap20),
                  const Gap(AppSize.gap20),
                  SignUpOrLoginText(
                    buttonText: context.loc.login,
                    prefixText: context.loc.alrady_have_account,
                    onTap: () {
                      context.goNamed(RouteNames.signIn.name);
                    },
                  ),
                  const Gap(AppSize.gap20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
