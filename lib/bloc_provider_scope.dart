import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/di.dart';
import 'package:fuel_delivery_app_user/features/auth/domain/usecases/auth_usecase.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/routes/routes.dart';

class BlocProviderScope extends StatelessWidget {
  const BlocProviderScope({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            checkEmailVerified: locator<CheckEmailVerifiedUsecaseImpl>(),
            checkSignInnUsecase: locator<CheckSignInUsecaseImpl>(),
            sendVerificationEmail: locator<SendVerificationEmaileUsecaseImpl>(),
            singInWithGoole: locator<SignInWithGoogleUsecaseImpl>(),
            signInUsecase: locator<SignInUsecaseImpl>(),
            singOutUsecase: locator<SingOutUsecaseImpl>(),
            saveUserDataUseCase: locator<SaveUserDataUsecaseImpl>(),
            signUpUsecase: locator<SignUpUsecaseImpl>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
      ),
    );
  }
}
