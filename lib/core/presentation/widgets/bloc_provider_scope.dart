import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/all_services/allservices_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/booking_service_bloc/booking_services_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/current_location/current_lcoation_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/controller/bloc/profile_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/di.dart';
import 'package:fuel_delivery_app_user/core/domain/usecases/auth_usecase.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class BlocProviderScope extends StatelessWidget {
  const BlocProviderScope({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentLcoationBloc>(
          create: (context) => CurrentLcoationBloc(),
        ),
        BlocProvider<BookingBloc>(
          create: (context) => BookingBloc(),
        ),
        BlocProvider<AllservicesBloc>(
          create: (context) => AllservicesBloc(),
        ),
        
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
        
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(),)
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: ColorPellet.scaffoldColor),
        // theme: ,
        localizationsDelegates: AppLocalizations.localizationsDelegates,

        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
