import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/profile_cubit/profile_cubit.dart';
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/models/address_model.dart';
import 'package:fuel_delivery_app_user/repository/profile_repository.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/add_address.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectAddressScreen extends StatefulWidget {
  bool enabled;
  SelectAddressScreen({super.key, this.enabled = false});

  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  String? selectedAddressId;
  final ProfileDateService _profileService = ProfileDateService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: widget.enabled
              ? () {
                  Navigator.pop(context);
                }
              : null,
          child: widget.enabled
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () {
                    if (widget.enabled) {
                      Navigator.pop(context);
                    }
                  },
                )
              : null,
        ),
        title: Text(
          'Select Address',
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAddressPage()),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(
                'Add New Address',
                style: GoogleFonts.montserrat(),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocConsumer<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileError) {
                  return Center(
                    child: Text(state.error),
                  );
                }

                if (state is ProfileLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProfileSuccess) {
                  return ListView.builder(
                    itemCount: state.profile.address?.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final address = state.profile.address![index];
                      final isSelected = index.toString() == selectedAddressId;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.black12,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: RadioListTile<String>(
                          value: index.toString(),
                          groupValue: state.profile.selectedAddress.toString(),
                          onChanged: (value) {
                            setState(() {
                              selectedAddressId = value;
                            });
                          },
                          title: Row(
                            children: [
                              Text(
                                address.addressType,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                address.fullName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                address.streetAddress,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${address.city}, ${address.state} ${address.postalCode}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Phone: ${address.phoneNumber}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  TextButton.icon(
                                    icon: const Icon(Icons.edit, size: 18),
                                    label: const Text('Edit'),
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    ),
                                  ),
                                  TextButton.icon(
                                    icon: const Icon(Icons.delete_outline,
                                        size: 18),
                                    label: const Text('Delete'),
                                    onPressed: () {
                                      List<AddressModel>? tempAddress =
                                          state.profile.address?.toList();
                                      tempAddress?.removeAt(index);
                                      if (state.profile.selectedAddress !=
                                              null &&
                                          index ==
                                              int.parse(state
                                                  .profile.selectedAddress
                                                  .toString())) {
                                        state.profile.selectedAddress = null;
                                      }
                                      context.read<ProfileCubit>().upDate(
                                            profile: state.profile.copyWith(
                                                address: tempAddress,
                                                selectedAddress: state
                                                    .profile.selectedAddress),
                                          );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          activeColor: Colors.black,
                        ),
                      );
                    },
                  );
                }

                return Text("Fetching data .....");
              },
              listener: (context, state) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedAddressId != null
                  ? () async {
                      try {
                        ProfileCubit profileCubit =
                            context.read<ProfileCubit>();

                        profileCubit.upDate(
                            profile: profileCubit.profileModel!.copyWith(
                                selectedAddress:
                                    int.parse(selectedAddressId.toString())));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to update address: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                'Confirm Selection',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
