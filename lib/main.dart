import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/di.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/firebase_options.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/bloc_provider_scope.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUP();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) => BlocProviderScope(),
    );
  }
}
