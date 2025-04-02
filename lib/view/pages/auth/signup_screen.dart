import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/auth_cubit/auth_cubit.dart';
import 'package:fuel_delivery_app_user/utils/constants/size.dart';
import 'package:fuel_delivery_app_user/utils/validators/text_validators.dart';
import 'package:fuel_delivery_app_user/view/routes/route_names.dart';
import 'package:fuel_delivery_app_user/view/routes/routes.dart';
import 'package:fuel_delivery_app_user/view/widgets/pass_word_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'widgets/auth_screen_logo.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  void _gotoLoginButtonPressed() {
    context.go(RouteNames.signIn.path);
  }

  void _signUpButtonPressed() {
    print(_nameController.text);
    print(_confirmPasswordController.text);
    print(_passwordController.text);
    print(_emailController.text);
    print(_phoneController.text);
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().singUP(
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text,
            phone: _phoneController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(AppSizes.defaultPadding),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          print("state from signup screen${state.toString()}");

          if (state is EmailVrification) {
            context.go(RouteNames.verifyEmail.path);
          }
          if (state is AuthFaild) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthScreenLogo(),
                  SizedBox(
                    height: AppSizes.defaultSapceBetweenWidget1,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: 'Name',
                      hintText: 'Enter your name',
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.defaultSpaceBetweenTextFields,
                  ),
                  TextFormField(
                      controller: _emailController,
                      validator: AppTextValidator.emailValidator,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Email',
                        hintText: 'Enter your email',
                      )),
                  const SizedBox(
                    height: AppSizes.defaultSpaceBetweenTextFields,
                  ),
                  TextFormField(
                      controller: _phoneController,
                      validator: AppTextValidator.phoneNumberValidatorr,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone_outlined),
                        labelText: 'Phone',
                        hintText: 'Enter your phone number',
                      )),
                  const SizedBox(
                    height: AppSizes.defaultSpaceBetweenTextFields,
                  ),
                  PassWordField(passwordController: _passwordController),
                  const SizedBox(
                    height: AppSizes.defaultSpaceBetweenTextFields,
                  ),
                  PassWordField(
                    passwordController: _confirmPasswordController,
                    isConfirmePassWord: true,
                    originalpasswordController: _passwordController,
                  ),
                  SizedBox(
                    height: AppSizes.defaultSapceBetweenWidget1 * 1.5,
                  ),
                  ElevatedButton(
                    onPressed: _signUpButtonPressed,
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(
                    height: AppSizes.defaultSpaceBetweenTextFields,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: _gotoLoginButtonPressed,
                        child: const Text('Login',
                            style: TextStyle(color: Colors.blue)),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
