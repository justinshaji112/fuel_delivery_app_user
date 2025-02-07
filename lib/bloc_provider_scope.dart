import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/cubit/auth_cubit.dart';
import 'package:fuel_delivery_app_user/di.dart';
import 'package:fuel_delivery_app_user/interface/repository/auth_repo.dart';

import 'package:fuel_delivery_app_user/utils/constants/colors.dart';
import 'package:fuel_delivery_app_user/controller/auth_bloc/auth_bloc.dart';

import 'package:fuel_delivery_app_user/controller/booking_service_bloc/booking_services_bloc.dart';
import 'package:fuel_delivery_app_user/controller/profile_bloc/profile_bloc.dart';
import 'package:fuel_delivery_app_user/view/routes/routes.dart';
import 'package:fuel_delivery_app_user/utils/theme/theme.dart';

class BlocProviderScope extends StatelessWidget {
  const BlocProviderScope({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        
     
        
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(),),
      BlocProvider<AuthBloc>(create:(context) => AuthBloc(), ),
      BlocProvider<AuthCubit>(create:(context) => AuthCubit(authRepo:getIt.get<AuthRepo>() )..checkLogedIn(), )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        theme: AppTheme.lightTheme,
            
      


        routerConfig: AppRouter.router,
      ),
    );
  }
}
