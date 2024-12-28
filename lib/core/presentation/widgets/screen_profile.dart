import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/config/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/app/constants/size.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/orders/order_history.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/profile_lsit_tile.dart';
import 'package:fuel_delivery_app_user/core/presentation/routes/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:fuel_delivery_app_user/app/constants/lottie_animatios.dart';

import '../bloc/auth_bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return Container(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LogOutState) {
            context.goNamed(RouteNames.signIn.name);
          }
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: ColorPellet.primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              height: 350.w,
              width: double.infinity,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 4,
                            color: Color.fromARGB(120, 0, 0, 0),
                            offset: Offset(4, 4)),
                        BoxShadow(
                            blurRadius: 4,
                            color: Color.fromARGB(39, 0, 0, 0),
                            offset: Offset(4, 4)),
                      ],
                      color: ColorPellet.primaryColor,
                      borderRadius: const BorderRadius.all(
                        Radius.elliptical(35, 35),
                      )),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          // padding: EdgeInsets.all(0),
                          // margin: EdgeInsets.all(0),
                          width: 170,
                          height: 170,
                          child: Lottie.asset(
                            AppLottie.profile,
                          ),
                        ),
                        Text(
                          FireSetup.auth.currentUser?.displayName != null
                              ? FireSetup.auth.currentUser!.displayName!
                              : " ",
                          style: TextStyle(
                              color: ColorPellet.white,
                              fontSize: AppSize.gap20 * 1.2,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          FireSetup.auth.currentUser!.email!,
                          style: TextStyle(color: ColorPellet.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ProfileTile(
                    desableTrailing: false,
                    onTap: () {},
                    leeding: Icons.history,
                    title: "Purchase History",
                  ),
                  ProfileTile(
                    desableTrailing: false,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrdersScreen(),
                      ));
                    },
                    leeding: Icons.inventory_2_outlined,
                    title: "Your Orders",
                  ),
                  ProfileTile(
                    desableTrailing: true,
                    onTap: () {
                      authBloc.add(LogoutPressedEvent());
                    },
                    leeding: Icons.logout,
                    title: "Logout",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
