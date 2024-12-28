// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/app/constants/colors.dart';

import 'package:fuel_delivery_app_user/core/presentation/bloc/all_services/allservices_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/current_location/current_lcoation_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/models/service_card_model.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/serveice_detail_page.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/service_detail_page.dart';
import 'package:fuel_delivery_app_user/core/presentation/widgets/banner_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<CurrentLcoationBloc>().add(GetLocationEvent());
    context.read<AllservicesBloc>().add(GetServicesEvnt());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPellet.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        foregroundColor: ColorPellet.transpirant,
        leading: const Icon(
          Icons.menu,
          color: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<CurrentLcoationBloc,
                          CurrentLcoationState>(
                        builder: (context, state) {
                          if (state is LocationGotState) {
                            return AddressCard(
                              icon: Icons.location_city,
                              title: "Current Location",
                              subTitle: state.cityName,
                            );
                          }
                          return const AddressCard(
                            icon: Icons.location_on,
                            title: "Add Address",
                            subTitle: "Calicut",
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: AddressCard(
                        icon: Icons.local_taxi_sharp,
                        subTitle: "hei",
                        title: "Select Vechile",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PromoBanner(),
              // OfferCard(),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 500,
                    child: GridView.builder(
                      itemCount: ServiceCards.cards.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.5,
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        ServiceCard card = ServiceCards.cards[index];
                        return InkWell(
                          // onTap: () {
                          //   razorpay.open(getTurboPaymentOptions());
                          // },
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ServeiceDetailPage(
                                      serviceType: card.key,
                                      serviceTitle: card.serviceType)
                                  // ServeiceDetailPage(
                                  //     serviceType: card.key,
                                  //     serviceTitle: card.serviceType),
                                  )),
                          child: ServiceCardWidget(
                              card.serviceType, card.imageUrl),
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCardWidget extends StatelessWidget {
  final String title;
  final String imagePath;

  const ServiceCardWidget(this.title, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20, // Reduced height from 100 to 80
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: const Color.fromARGB(112, 0, 0, 0),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subTitle;

  const AddressCard({
    super.key,
    required this.title,
    required this.icon,
    required this.subTitle,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(71, 164, 206, 241),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(icon, color: Colors.blue),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        subTitle,
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
