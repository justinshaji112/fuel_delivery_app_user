import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/features/auth/domain/usecases/auth_usecase.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/routes/route_names.dart';
import 'package:go_router/go_router.dart';

class LoginRoutManger extends StatelessWidget {
  const LoginRoutManger({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(CheckLoginEvent());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AlradySignInedState) {
          return context.goNamed(RouteNames.home.name);
        } else {
          return context.goNamed(RouteNames.onBoarding.name);
        }
      },
    );
    //  BlocListener(
    //   listener: (context, state) {
    //     if (state is UserNeverSingedState) {
    //       return context.goNamed(RouteNames.onBoarding.name);
    //     } else {
    //       return context.goNamed(RouteNames.home.name);
    //     }
    //   },
    // );
  }
}
