import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/view/pages/auth/login_screen.dart';
import 'package:fuel_delivery_app_user/view/pages/auth/manage_login.dart';
import 'package:fuel_delivery_app_user/view/routes/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  // Sample user data (would typically come from a state management solution)
  final Map<String, dynamic> userData = {
    'name': FireSetup.auth.currentUser?.displayName,
    'email': FireSetup.auth.currentUser?.email,
    'profileImage': '',
    'memberSince': ''
  };

  // Profile menu items
  final List<Map<String, dynamic>> _profileMenuItems = [
    {
      'icon': Icons.car_repair,
      'title': 'My Vehicles',
      'subtitle': 'Manage your registered vehicles',
      'route': '/vehicles'
    },
    {
      'icon': Icons.location_on,
      'title': 'Addresses',
      'subtitle': 'Manage delivery and charging locations',
      'route': '/addresses'
    },
    {
      'icon': Icons.history,
      'title': 'Order History',
      'subtitle': 'View past Orders',
      'route': '/order-history'
    },
    {
      'icon': Icons.payment,
      'title': 'Payment Methods',
      'subtitle': 'Add or remove payment options',
      'route': '/payment-methods'
    },
    {
      'icon': Icons.settings,
      'title': 'App Settings',
      'subtitle': 'Customize your app experience',
      'route': '/settings'
    },
    {
      'icon': Icons.support,
      'title': 'Customer Support',
      'subtitle': 'Get help and contact support',
      'route': '/support'
    }
  ];

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              _buildProfileHeader(context),

              // Profile Menu
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Profile Options',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Profile Menu Items
              ..._buildProfileMenuItems(context),

              // Logout Section
              _buildLogoutSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 50,
            backgroundImage: userData['profileImage'] != null
                ? NetworkImage(userData['profileImage'])
                : null,
            child: userData['profileImage'] == null
                ? const Icon(Icons.person, size: 50)
                : null,
          ),

          const SizedBox(width: 20),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData['name'] ?? " ",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  userData['email'] ?? "",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Member Since: ${userData['memberSince'] ?? ""}',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to edit profile
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildProfileMenuItems(BuildContext context) {
    return _profileMenuItems.map((item) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                item['icon'],
                color: Colors.black,
                size: 24,
              ),
            ),
            title: Text(
              item['title'],
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              item['subtitle'],
              style: GoogleFonts.montserrat(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.black54,
            ),
            onTap: () {
              // Navigation logic
              // Navigator.pushNamed(context, item['route']);
              context.go("/order-history");
            },
          ),
        ),
      );
    }).toList();
  }

  Widget _buildLogoutSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.logout,
              color: Colors.red,
              size: 24,
            ),
          ),
          title: Text(
            'Logout',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.red,
            ),
          ),
          onTap: () async {
            await FireSetup.auth.signOut();
            context.go(RouteNames.signIn.path);
            // Show logout confirmation dialog
            // _showLogoutConfirmationDialog(context);
          },
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext widgetContext) {
    showDialog(
      context: widgetContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.montserrat(),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.montserrat(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.montserrat(color: Colors.white),
              ),
              onPressed: () async {
                await FireSetup.auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginManager(),
                    ),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
