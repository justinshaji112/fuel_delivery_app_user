import 'package:fuel_delivery_app_user/view/pages/auth/forgot_password_screen.dart';
import 'package:fuel_delivery_app_user/view/pages/auth/login_screen.dart';
import 'package:fuel_delivery_app_user/view/pages/auth/manage_login.dart';
import 'package:fuel_delivery_app_user/view/pages/auth/signup_screen.dart';
import 'package:fuel_delivery_app_user/view/pages/auth/verify_email_screen.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/home.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/screen_home.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/select_address.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/select_vehicle.dart';
import 'package:fuel_delivery_app_user/view/routes/route_names.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: RouteNames.checkLogedIn.path,
    routes: <RouteBase>[
      //login page
      GoRoute(
          path: RouteNames.signIn.path,
          builder: (context, state) => const LoginPage()),

      //signup page
      GoRoute(
          path: RouteNames.singUp.path,
          builder: (context, state) => const SignupScreen()),

      /*
      this route is used to manage the login and home page
      user authedicated -> home page
      user not authedicated -> login page  
       */
      GoRoute(
          path: RouteNames.checkLogedIn.path,
          builder: (context, state) => const LoginManager()),

      //Home page
      GoRoute(
          path: RouteNames.home.path,
          builder: (context, state) => const HomeScreen()),

      //Verify email page
      GoRoute(
          path: RouteNames.verifyEmail.path,
          builder: (context, state) => const VerifyEmailScreen()),


      //Forgot password screen
      GoRoute(
          path: RouteNames.forgotPassword.path,
          builder: (context, state) => const ForgotPasswordScreen()),


        
    ],
  );
}
