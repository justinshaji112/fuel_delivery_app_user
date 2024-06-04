import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_delivery_app_user/routes/route_names.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';
import 'package:fuel_delivery_app_user/app/constants/images.dart';
import 'package:fuel_delivery_app_user/app/constants/size.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPellet.primaryColor,
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: <Widget>[
            Image(width: 400.w, image: AssetImage(ImageUrls.carIstration)),
            Align(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  "Order, Track, and Relax as We Deliver Fuel to You",
                  style: GoogleFonts.amarante(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170),
              child: GestureDetector(
                onTap: () {
                  context.goNamed(RouteNames.signIn.name);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorPellet.black,
                      borderRadius: BorderRadius.circular(10)),
                  width: 330.w,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Get Started",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: ColorPellet.white,
                            fontSize: 15),
                      ),
                      const SizedBox(
                        width: AppSize.gap20,
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 50),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
