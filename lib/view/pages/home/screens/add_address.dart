import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/profile_cubit/profile_cubit.dart';

import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/models/address_model.dart';
import 'package:fuel_delivery_app_user/utils/helpers/snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddressPage extends StatefulWidget {
  AddressModel? address;
  AddAddressPage({super.key, this.address});

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // Address Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  // Dropdown values
  String _selectedCountry = 'United States';

  // Country options
  final List<String> _countryOptions = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'India',
    'Germany',
    'France',
    'Japan',
    'Brazil',
    'Other'
  ];

  // Address Type
  String _selectedAddressType = 'Home';
  final List<String> _addressTypes = [
    'Home',
    'Work',
    'Charging Station',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add Address',
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address Details',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Address Type Dropdown
                _buildDropdownField(
                  label: 'Address Type',
                  items: _addressTypes,
                  value: _selectedAddressType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedAddressType = newValue!;
                    });
                  },
                ),

                const SizedBox(height: 15),

                // Full Name Input
                _buildTextFormField(
                  controller: _fullNameController,
                  label: 'Full Name',
                  hint: 'Enter full name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Phone Number Input
                _buildTextFormField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hint: 'Enter phone number',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    // Basic phone number validation
                    String pattern =
                        r'^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$';
                    if (!RegExp(pattern).hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Street Address Input
                _buildTextFormField(
                  controller: _streetController,
                  label: 'Street Address',
                  hint: 'Street address or P.O. box',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter street address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Apartment/Unit Input
                _buildTextFormField(
                  controller: _apartmentController,
                  label: 'Apartment/Unit (Optional)',
                  hint: 'Apartment, suite, unit, etc.',
                  required: false,
                ),

                const SizedBox(height: 15),

                // Country Dropdown
                _buildDropdownField(
                  label: 'Country',
                  items: _countryOptions,
                  value: _selectedCountry,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCountry = newValue!;
                    });
                  },
                ),

                const SizedBox(height: 15),

                // City Input
                _buildTextFormField(
                  controller: _cityController,
                  label: 'City',
                  hint: 'Enter city name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // State/Province Input
                _buildTextFormField(
                  controller: _stateController,
                  label: 'State/Province',
                  hint: 'Enter state or province',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter state/province';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Postal Code Input
                _buildTextFormField(
                  controller: _postalCodeController,
                  label: 'Postal Code',
                  hint: 'Enter postal code',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter postal code';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Submit Button
                Center(
                  child: BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileSuccess) {
                        AppSnackBars.showSuccessSnackBar(
                            context, "Address is added");
                        context.pop();
                      }
                      if (state is ProfileError) {
                        AppSnackBars.showErrorSnackBar(context, state.error);
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          ProfileCubit profileCubit =
                              context.read<ProfileCubit>();
                          if (profileCubit.profileModel != null) {
                            profileCubit.profileModel!.address?.add(
                                AddressModel(
                                    country: _selectedCountry,
                                    phoneNumber: _phoneController.text,
                                    city: _cityController.text,
                                    streetAddress: _streetController.text,
                                    addressType: _selectedAddressType,
                                    postalCode: _postalCodeController.text,
                                    apartmentUnit: _apartmentController.text,
                                    fullName: _fullNameController.text,
                                    state: _stateController.text));
                            profileCubit.upDate(
                                profile: profileCubit.profileModel!);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: state is ProfileLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Save Address',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom Text Form Field Builder
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool required = true,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: required ? validator : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        fillColor: Colors.white,
        filled: true,
        labelStyle: GoogleFonts.montserrat(
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: GoogleFonts.montserrat(
          color: Colors.black38,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // Custom Dropdown Field Builder
  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    required String value,
    required void Function(String?)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12, width: 1.5),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.montserrat(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        items: items.map((String type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(
              type,
              style: GoogleFonts.montserrat(),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  // Submit Address Details Method
  // Future<void> _submitAddressDetails() async {
  //   if (_formKey.currentState!.validate()) {
  //     // Collect all address details
  //     final addressDetails = {
  //       'addressType': _selectedAddressType,
  //       'fullName': _fullNameController.text,
  //       'phoneNumber': _phoneController.text,
  //       'streetAddress': _streetController.text,
  //       'apartmentUnit': _apartmentController.text,
  //       'country': _selectedCountry,
  //       'city': _cityController.text,
  //       'state': _stateController.text,
  //       'postalCode': _postalCodeController.text,
  //     };

  //     // TODO: Implement your logic to save address details
  //     // For now, we'll just print the details
  //     print('Address Details: $addressDetails');

  //     await FireSetup.profile.get().then((value) async {
  //       List<dynamic> existingAddresses = value.data()?['address'] ?? [];
  //       existingAddresses.add(addressDetails);

  //       return await FireSetup.profile.update({"address": existingAddresses});
  //     }

  //     ).then(
  //       (value) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               'Address Added Successfully!',
  //               style: GoogleFonts.montserrat(),
  //             ),
  //             backgroundColor: Colors.green,
  //           ),
  //         );
  //       },
  //     ).onError(
  //       (error, stackTrace) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               '${error.toString()}!',
  //               style: GoogleFonts.montserrat(),
  //             ),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //       },
  //     );
  //     // Optional: Show a success dialog or navigate to another page
  //   }
  // }
}
