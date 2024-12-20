
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/app/constants/lottie_animatios.dart';
import 'package:fuel_delivery_app_user/core/data/models/service_model.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/all_services/allservices_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/service_details_card.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';


class ServeiceDetailPage extends StatelessWidget {
 final String serviceType;
final String serviceTitle;
const ServeiceDetailPage({
 super.key,
 required this.serviceType,
required this.serviceTitle,
 });


@override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<AllservicesBloc, AllservicesState>(
          builder: (context, state) {
            if (state is ServiceGotState) {
              List<ServiceModel>? services = state.services[serviceType];
              if (services == null || services.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Lottie.asset(AppLottie.globeLoading),
                      const Gap(30),
                      const Text(
                        "No Services found in this Area",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const Text(
                        "Try changing the location",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      )
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) => ServiceDetailCard(
                  service: services[index],
                ),
              );
            }
            return Column(
              children: [
                Lottie.asset(AppLottie.globeLoading),
                const Gap(30),
                const Text(
                  "No Data found",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
