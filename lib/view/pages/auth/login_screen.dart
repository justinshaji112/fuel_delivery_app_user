import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/cubit/auth_cubit.dart';
import 'package:fuel_delivery_app_user/utils/constants/size.dart';
import 'package:fuel_delivery_app_user/utils/constants/text_string.dart';
import 'package:fuel_delivery_app_user/utils/validators/text_validators.dart';
import 'package:fuel_delivery_app_user/view/pages/auth/widgets/auth_screen_logo.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/home.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/screen_home.dart';
import 'package:fuel_delivery_app_user/view/routes/route_names.dart';
import 'package:fuel_delivery_app_user/view/routes/routes.dart';
import 'package:fuel_delivery_app_user/view/widgets/app_checkbox.dart';
import 'package:fuel_delivery_app_user/view/widgets/google_button.dart';
import 'package:fuel_delivery_app_user/view/widgets/pass_word_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // onpressed of google button

  void _googleButtonPressed() {
    context.read<AuthCubit>().signInWithGoogle();
  }

  // onpressed of login
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
            email: _emailController.text,
            password: _passwordController.text,
          );
    }
  }

//forgot password text button on pressed

  void _forgotPasswordButtionPressed() {
    context.go(RouteNames.forgotPassword.path);
  }

  // sign up text button pressed
  void _signUpButtonPressed() {
    context.go(RouteNames.singUp.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is EmailVrification) {
              context.go(RouteNames.verifyEmail.path);
            }
            if (state is AuthSucess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (Route<dynamic> route) => false);
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
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.defaultPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),

                      ///
                      // App Logo
                      const AuthScreenLogo(),

                      const SizedBox(height: 40),

                      // Welcome Text
                      _buildWellcomeText(context),

                      const SizedBox(
                          height: AppSizes.defaultSpaceBetweenTextFields),
                      // Subtitle

                      builSubtitle(context),

                      const SizedBox(height: 40),

                      // Email Input
                      _buildEmailInputField(),

                      const SizedBox(height: 20),

                      // Password Input
                      PassWordField(passwordController: _passwordController),

                      const SizedBox(height: 20),

                      _buildRemebermeAndForgotPassword(),

                      const SizedBox(height: 20),

                      // Login Button
                      _loginButton(),

                      const SizedBox(height: 20),

                      // Social Login Options
                      ..._buildSocialLogin(context),
                      // Don't have an account
                      _buildSignUpOption(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Row _buildSignUpOption() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        AppStrings.loginNoAccount,
      ),
      TextButton(
          onPressed: _signUpButtonPressed,
          child: const Text(
            AppStrings.loginSignUp,
          ))
    ]);
  }

  List<Widget> _buildSocialLogin(BuildContext context) {
    return [
      const Text(
        AppStrings.loginWithSocial,
      ),
      const SizedBox(height: 20),
      //google login
      GoogleButton(
        onPressed: _googleButtonPressed,
      ),

      const SizedBox(height: 30),
    ];
  }

  ElevatedButton _loginButton() {
    return ElevatedButton(
      onPressed: _handleLogin,
      child: const Text(
        AppStrings.loginButton,
      ),
    );
  }

  Row _buildRemebermeAndForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            AppCheckBox(
              value: _rememberMe,
              onchanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
            const SizedBox(width: 8),
            Text(
              AppStrings.loginRememberMe,
              style: GoogleFonts.montserrat(
                color: Colors.black54,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: _forgotPasswordButtionPressed,
          child: const Text(
            AppStrings.loginForgotPassword,
          ),
        ),
      ],
    );
  }

  TextFormField _buildEmailInputField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        labelText: AppStrings.email,
        hintText: AppStrings.emailHint,
      ),
      validator: AppTextValidator.emailValidator,
    );
  }

  Text builSubtitle(BuildContext context) {
    return Text(
      AppStrings.loginSubTitle,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Text _buildWellcomeText(BuildContext context) {
    return Text(
      AppStrings.loginTitle,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
