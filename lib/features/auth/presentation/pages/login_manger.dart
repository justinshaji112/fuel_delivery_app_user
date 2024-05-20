// import 'package:flutter/material.dart';
// import 'package:fuel_delivery_app_user/di.dart';
// import 'package:fuel_delivery_app_user/features/auth/domain/usecases/auth_usecase.dart';
// import 'package:fuel_delivery_app_user/features/auth/domain/usecases/sign_up_usecase.dart';
// import 'package:fuel_delivery_app_user/features/auth/presentation/pages/login_page.dart';
// import 'package:fuel_delivery_app_user/features/home/presentation/screen_home.dart';
// class LoginManger extends StatelessWidget {
//   const LoginManger({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//               future: locator<CheckSignInUsecaseImpl>().exicute(),
//               builder: (context, snapshot) {
//                 if (snapshot.data == null) {
//                   return LoginScreen();
//                 } else {
//                   return HomeScreen();
                  
//                 }
//               },
//             );
//   }
// }