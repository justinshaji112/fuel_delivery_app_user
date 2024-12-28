import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/home.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/location_screen.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/screens/add_address.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/screens/profile_page.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/screens/select_address.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/screen_profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hugeicons/hugeicons.dart';
import '../pages/home/screens/new_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Widget> screens = [
  const NewHomePage(),
  // LocationScreen(),
  const AddressListPage(),
  // const ProfileScreen(),
  ProfilePage()
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
        activeColor: Colors.black,
        iconSize: 24,
        tabBackgroundColor: const Color.fromARGB(62, 0, 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        backgroundColor: ColorPellet.white,
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
