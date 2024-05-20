import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/features/auth/presentation/pages/login_page.dart';
import 'package:fuel_delivery_app_user/features/home/presentation/home.dart';
import 'package:fuel_delivery_app_user/features/home/presentation/screen_location.dart';
import 'package:fuel_delivery_app_user/features/home/presentation/screen_profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Widget> screens = [
  Home(),
  LocationScreen(),
  ProfileScreen(),
];

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: GNav(
        onTabChange: (value) {
          index = value;
          setState(() {});
        },
        tabBorderRadius: 15,
        duration: const Duration(milliseconds: 900),
        gap: 8,
        activeColor: ColorPellet.primaryColor,
        iconSize: 24,
        tabBackgroundColor: Color.fromARGB(34, 35, 137, 220),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        backgroundColor: ColorPellet.white,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            icon: Icons.location_on,
            text: "Location",
          ),
          GButton(
            icon: Icons.person,
            text: "Profile",
          ),
        ],
      ),
    );
  }
}
