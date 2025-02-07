import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/utils/constants/colors.dart';
import 'package:fuel_delivery_app_user/controller/auth_bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/home.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/profile_page.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/select_address.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Widget> screens = [
  const HomeScreenContent(),
  // LocationScreen(),
  AddressListPage(),
  // const ProfileScreen(),
  ProfilePage()
];

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
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
        activeColor: Colors.black,
        iconSize: 24,
        tabBackgroundColor: const Color.fromARGB(62, 0, 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        backgroundColor: AppColors.white,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        tabs: const [
          GButton(
            icon: HugeIcons.strokeRoundedHome05,
            // text: "Home",
          ),
          GButton(
            icon: HugeIcons.strokeRoundedLocation05,
            // text: "Location",
          ),
          GButton(
            icon: HugeIcons.strokeRoundedUser,
            // text: "Profile",
          ),
        ],
      ),
    );
  }
}
