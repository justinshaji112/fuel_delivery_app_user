import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/auth_cubit/auth_cubit.dart';
import 'package:fuel_delivery_app_user/controller/carousel_cubit/carousel_cubit.dart';
import 'package:fuel_delivery_app_user/controller/profile_cubit/profile_cubit.dart';
import 'package:fuel_delivery_app_user/controller/service_cubit/service_cubit.dart';
import 'package:fuel_delivery_app_user/models/address_model.dart';
import 'package:fuel_delivery_app_user/models/carousel_model.dart';
import 'package:fuel_delivery_app_user/models/vehicle_model.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/select_address.dart';
import 'package:fuel_delivery_app_user/view/pages/home/widgets/carousel_widget.dart';
import 'package:fuel_delivery_app_user/view/pages/home/widgets/home_appbar_location_vehicle_widget.dart';
import 'package:fuel_delivery_app_user/view/pages/home/widgets/home_screen_profile_button.dart';
import 'package:fuel_delivery_app_user/view/pages/home/widgets/show_top_services_widget.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';

import 'package:fuel_delivery_app_user/repository/profile_repository.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/select_vehicle.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/service_detaile_page.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    // context.read<CarouselCubit>().getCarousels();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            actions: const [HomeProfileIcon()],
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "EcoBolt",
              style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            floating: true,
            snap: true,
          ),
        ],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopAppBar(),
                  const Gap(30),
                  Text(
                    "Top Services",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  const Gap(15),
                  const TopServicesWidget(),
                  const Gap(25),
                  BlocBuilder<CarouselCubit, CarouselState>(
                    builder: (context, state) {
                      if (state is CarouselLoading) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          width: double.infinity,
                          height: 170.0,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.blueGrey,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                      if (state is CarouselSuccess) {
                        return CarouselWidget(
                          carousels: state.carousels,
                        );
                      }
                      return Container();
                    },
                  ),
                  const Gap(25),
                  Text(
                    "Our Services",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  const Gap(15),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: BlocBuilder<ServiceCubit, ServiceState>(
                      builder: (context, state) {
                        if (state is ServiceLoading ||
                            state is ServiceInitial) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (state is ServiceSuccess && state.services.isEmpty) {
                          return const Center(
                              child: Text('No services available'));
                        }

                        if (state is ServiceError) {
                          return Center(
                            child: Text(state.error),
                          );
                        }

                        if (state is ServiceSuccess) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              childAspectRatio: 0.8,
                            ),
                            padding: const EdgeInsets.all(8),
                            itemCount: state.services.length,
                            itemBuilder: (context, index) {
                              final servicesSnapshot = state.services;
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceBookingPage(
                                              service: servicesSnapshot[index],
                                            ))),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 50,
                                          child: Image.network(
                                            servicesSnapshot[index].imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          servicesSnapshot[index].name,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        return Center(
                          child: Text(
                              "Something went worong. please reatart the app"),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}









