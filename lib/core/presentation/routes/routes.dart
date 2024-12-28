import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/auth/login_page.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/screens/new_home.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/onboarding/on_bording.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/auth/signup.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/auth/validate_email.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/screen_home.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/login_manger.dart';
import 'package:fuel_delivery_app_user/core/presentation/routes/route_names.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: RouteNames.checkLogedIn.path,
    routes: <RouteBase>[
      GoRoute(
        name: RouteNames.home.name,
        path: RouteNames.home.path,
        pageBuilder: (context, state) => const MaterialPage(
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.checkLogedIn.name,
        path: RouteNames.checkLogedIn.path,
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginRoutManger(),
        ),
      ),
      GoRoute(
        name: RouteNames.onBoarding.name,
        path: RouteNames.onBoarding.path,
        pageBuilder: (context, state) => const MaterialPage(
          child: OnBoarding(),
        ),
      ),
      GoRoute(
        name: RouteNames.signIn.name,
        path: RouteNames.signIn.path,
        pageBuilder: (context, state) => MaterialPage(
          child: SingInPage(),
        ),
      ),
      GoRoute(
        name: RouteNames.singUp.name,
        path: RouteNames.singUp.path,
        pageBuilder: (context, state) =>
            const MaterialPage(child: SignUpScreen()),
      ),
      GoRoute(
        name: RouteNames.validateEmail.name,
        path: RouteNames.validateEmail.path,
        pageBuilder: (context, state) => MaterialPage(child: ValidateEmail()),
      ),
    ],
  );
}
