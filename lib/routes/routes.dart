import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/pages/login_page.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/pages/on_bording.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/pages/signup.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/pages/validate_email.dart';
import 'package:fuel_delivery_app_user/features/home/presentation/screen_home.dart';
import 'package:fuel_delivery_app_user/login_manger.dart';
import 'package:fuel_delivery_app_user/routes/route_names.dart';
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
        pageBuilder: (context, state) => MaterialPage(child: SignUpScreen()),
      ),
      GoRoute(
        name: RouteNames.validateEmail.name,
        path: RouteNames.validateEmail.path,
        pageBuilder: (context, state) => MaterialPage(child: ValidateEmail()),
      ),
    ],
  );
}
