import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/auth_cubit/auth_cubit.dart';
import 'package:fuel_delivery_app_user/controller/carousel_cubit/carousel_cubit.dart';
import 'package:fuel_delivery_app_user/controller/order_cubit/order_cubit.dart';
import 'package:fuel_delivery_app_user/controller/profile_cubit/profile_cubit.dart';
import 'package:fuel_delivery_app_user/controller/service_cubit/service_cubit.dart';
import 'package:fuel_delivery_app_user/di.dart';
import 'package:fuel_delivery_app_user/interface/repository/auth_repo.dart';
import 'package:fuel_delivery_app_user/repository/carousel_repository.dart';
import 'package:fuel_delivery_app_user/repository/order_repository.dart';
import 'package:fuel_delivery_app_user/repository/profile_repo.dart';
import 'package:fuel_delivery_app_user/repository/service_repo.dart';

import 'package:fuel_delivery_app_user/utils/constants/colors.dart';

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
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authRepo: getIt.get<AuthRepo>())..checkLogedIn(),
        ),
        BlocProvider<ServiceCubit>(
          create: (context) =>
              ServiceCubit(servicesRepo: getIt.get<ServicesRepo>())
                ..getServices(),
        ),
        BlocProvider<CarouselCubit>(
          create: (context) =>
              CarouselCubit(carouselRepository: CarouselRepository()),
        ),
         BlocProvider<ProfileCubit>(
          create: (context) =>
              ProfileCubit(profileRepo: ProfileRepo()),
        ),

             BlocProvider<OrderCubit>(
          create: (context) =>
              OrderCubit(orderRepository: OrderRepository()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
