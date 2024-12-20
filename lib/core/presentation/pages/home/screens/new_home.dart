import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/config/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/models/services_model.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/controller/bloc/profile_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/screens/add_vechile.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/screens/select_vehicle.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/screens/service_detaile_page.dart';
import 'package:fuel_delivery_app_user/core/services/profile_date_service.dart';
import 'package:fuel_delivery_app_user/core/services/service_page_services.dart';
import 'package:gap/gap.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileDateService().gatProfileDataNormaly();
  }

  @override
  Widget build(BuildContext context) {
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
                  const HomeCaroselWidget(),
                  const Gap(25),
                  Text(
                    "Our Services",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  const Gap(15),
                  StreamBuilder<List<Service>>(
                    stream: ServiceMangementService().getServices(),
                    builder: (context, snapshot) {
                      print("dat is ");
                      print(snapshot.data);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No services available'));
                      }

                      final servicesSnapshot = snapshot.data!;

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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ServiceBookingPage(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                    },
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

class HomeProfileIcon extends StatelessWidget {
  const HomeProfileIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 185, 184, 184),
                    shape: BoxShape.circle),
                height: 35,
                width: 35,
                child: Center(
                    child: FireSetup.auth.currentUser!.displayName != null
                        ? Text(
                            FireSetup.auth.currentUser!.displayName!
                                        .split(" ")
                                        .first[0] +
                                    FireSetup.auth.currentUser!.displayName!
                                        .split(" ")[1][0] ??
                                "",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )
                        : const Icon(Icons.person))));
      },
    );
  }
}

class HomeCaroselWidget extends StatefulWidget {
  const HomeCaroselWidget({
    super.key,
  });

  @override
  State<HomeCaroselWidget> createState() => _HomeCaroselWidgetState();
}

class _HomeCaroselWidgetState extends State<HomeCaroselWidget> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<Widget> carouselItems = [
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/400/200'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/400/201'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/400/202'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: carouselItems,
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 170,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            enlargeFactor: 0.15,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselItems.asMap().entries.map((entry) {
            return Container(
              width: _currentIndex == entry.key ? 20 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: _currentIndex == entry.key
                    ? Colors.black
                    : Colors.grey[300],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class TopServicesWidget extends StatelessWidget {
  const TopServicesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> topServices = [
      {'name': 'Quick Repair', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Emergency', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Maintenance', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Diagnostics', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Towing', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Cleaning', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Parts', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Insurance', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Booking', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Support', 'image': 'assets/images/11-2-car-picture.png'},
    ];

    return SizedBox(
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topServices.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              width: 85,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: Image.asset(
                      topServices[index]['image'],
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    topServices[index]['name'],
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileInitial) {
          context.read<ProfileBloc>().add(FetchProfileData());
        }
      },
      builder: (context, state) {

        
        return Row(
          children: [
            const Expanded(
              child: AddressCard(
                  title: "Location",
                  icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image(
                      image: AssetImage("assets/images/map_location.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  subTitle: "manippara kerala, india 670705"),
            ),
            const Gap(12),
            Expanded(
                child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VehicleSelectionPage(),
                  )),
              child: const AddressCard(
                title: "Vehicle",
                icon: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image(
                    image: AssetImage("assets/images/11-2-car-picture.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                subTitle: "car",
              ),
            ))
          ],
        );
      },
    );
  }
}

class AddressCard extends StatelessWidget {
  final String title;
  final Widget icon;
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        subTitle,
                        style: GoogleFonts.montserrat(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Icon(Icons.arrow_drop_down,
                        color: Colors.grey[600], size: 20),
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
