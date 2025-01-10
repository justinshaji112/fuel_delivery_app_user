import 'package:bloc_connectivity/main.dart';
import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';

import 'package:fuel_delivery_app_user/view/pages/auth/login_page.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/order_history.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/screen_home.dart';
import 'package:fuel_delivery_app_user/view/routes/route_names.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: RouteNames.checkLogedIn.path,
    routes: <RouteBase>[
      GoRoute(
        name: RouteNames.OrderHistory.name,
        path: RouteNames.OrderHistory.path,
        pageBuilder: (context, state) => const MaterialPage(
          child: OrderHistoryPage(),
        ),
      ),
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
        pageBuilder: (context, state) => MaterialPage(
          child: FireSetup.auth.currentUser != null
              ? const HomeScreen()
              : const LoginPage(),
        ),
      ),
      GoRoute(
        name: RouteNames.onBoarding.name,
        path: RouteNames.onBoarding.path,
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginPage(),
        ),
      ),
      GoRoute(
        name: RouteNames.signIn.name,
        path: RouteNames.signIn.path,
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginPage(),
        ),
      ),
      GoRoute(
        name: RouteNames.singUp.name,
        path: RouteNames.singUp.path,
        pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
      ),
      GoRoute(
        name: RouteNames.validateEmail.name,
        path: RouteNames.validateEmail.path,
        pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
      ),
    ],
  );
}
