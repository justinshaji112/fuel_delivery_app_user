import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/profile_cubit/profile_cubit.dart';
import 'package:fuel_delivery_app_user/models/address_model.dart';
import 'package:fuel_delivery_app_user/models/vehicle_model.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/home.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/select_vehicle.dart';
import 'package:fuel_delivery_app_user/view/pages/home/widgets/home_appbar_vechile_address_tail.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Row(
            children: [
              Expanded(
                child: Shimmer.fromColors(
                    enabled: true,
                    child: Container(
                      width: 40,
                      height: 40,
                    ),
                    baseColor: Colors.blueGrey,
                    highlightColor: Colors.grey),
              ),
              const Gap(12),
              Expanded(
                child: Shimmer.fromColors(
                    enabled: true,
                    baseColor: Colors.blueGrey,
                    highlightColor: Colors.grey,
                    child: Container(
                      width: 100,
                      height: 40,
                    )),
              ),
            ],
          );
        }

        if (state is ProfileSuccess) {
          AddressModel? selectedAddress;
          VehicleModel? selectedVehicle;
          if (state.profile.address.isNotEmpty) {
            selectedAddress = state.profile
                .address[int.parse(state.profile.selectedAddress.toString())];
            selectedVehicle = state.profile.vehicles[
                int.parse(state.profile.selectedAddress.toString()) - 1];
          }

          return Row(
            children: [
              Expanded(
                child: GestureDetector(
                  // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: ()=>)),
                  child: AddressCard(
                    title: selectedAddress?.fullName ?? "Location",
                    icon: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Image(
                        image: AssetImage("assets/images/map_location.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    subTitle: selectedAddress?.city ?? "Add Address",
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VehicleSelectionPage(),
                    ),
                  ),
                  child: AddressCard(
                    title: selectedVehicle?.model ?? "Vehicle",
                    icon: const SizedBox(
                      width: 50,
                      height: 50,
                      child: Image(
                        image: AssetImage("assets/images/11-2-car-picture.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    subTitle: selectedVehicle?.model ?? "Add Vehicle",
                  ),
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
