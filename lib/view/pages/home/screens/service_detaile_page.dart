import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/controller/order_cubit/order_cubit.dart';
import 'package:fuel_delivery_app_user/controller/profile_cubit/profile_cubit.dart';
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';
import 'package:fuel_delivery_app_user/models/order_model.dart';
import 'package:fuel_delivery_app_user/models/profile_model.dart';
import 'package:fuel_delivery_app_user/models/service_model.dart';

import 'package:fuel_delivery_app_user/models/address_model.dart';
import 'package:fuel_delivery_app_user/models/vehicle_model.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/select_address.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/select_vehicle.dart';
import 'package:fuel_delivery_app_user/view/routes/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ServiceBookingPage extends StatefulWidget {
  final ServiceModel service;
  const ServiceBookingPage({super.key, required this.service});

  @override
  _ServiceBookingPageState createState() => _ServiceBookingPageState();
}

class _ServiceBookingPageState extends State<ServiceBookingPage> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));

  String? _selectedTimeSlot;
  SubServiceModel? _selectedService;
  VehicleModel? selectedVehicle;
  AddressModel? selectedAddress;

  // Generate time slots
  List<String> _generateTimeSlots() {
    List<String> timeSlots = [];
    for (int hour = 7; hour < 21; hour++) {
      timeSlots.add(
          '${hour.toString().padLeft(2, '0')}:00 - ${(hour + 1).toString().padLeft(2, '0')}:00');
    }
    return timeSlots;
  }

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
          'Book ${widget.service.name}',
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileSuccess) {
            ProfileModel profileModel = state.profile.copyWith();
            if (profileModel.selectedAddress != null) {
              selectedAddress =
                  profileModel.address[profileModel.selectedAddress!];
            }
            if (profileModel.selectedVehicle != null) {
              selectedVehicle =
                  profileModel.vehicles[profileModel.selectedVehicle! - 1];
            }
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vehicle Details Section
                  _buildSectionHeader('Selected Vehicle'),
                  selectedVehicle != null
                      ? _buildVehicleDetails(selectedVehicle!)
                      : const Center(child: Text("No vehicle selected")),

                  const SizedBox(height: 20),

                  // Address Details Section
                  _buildSectionHeader(' Location'),
                  selectedAddress != null
                      ? _buildAddressDetails(selectedAddress!)
                      : const Center(child: Text("No address selected")),

                  const SizedBox(height: 20),

                  // Service Options Section
                  _buildSectionHeader('Services'),
                  _buildServiceOptions(widget.service),

                  const SizedBox(height: 20),

                  // Date Selection
                  _buildSectionHeader('Select Date'),
                  _buildDatePicker(),

                  const SizedBox(height: 20),

                  // Time Slot Selection
                  _buildSectionHeader('Select Time Slot'),
                  _buildTimeSlotSelection(),

                  const SizedBox(height: 30),

                  // Book Now Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _validateAndBook(
                          selectedVehicle != null && selectedAddress != null),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Book Now',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Section Header Widget
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Vehicle Details Widget
  Widget _buildVehicleDetails(VehicleModel vehicle) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VehicleSelectionPage(),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailRow(label: 'Make', value: vehicle.make),
            DetailRow(label: 'Model', value: vehicle.model),
            DetailRow(label: 'Year', value: vehicle.year),
            if (vehicle.isElectric) ...[
              DetailRow(
                  label: 'Battery Capacity',
                  value: vehicle.batteryCapacity ?? ''),
              DetailRow(
                  label: 'Charger Type', value: "${vehicle.chargerType}" ?? ''),
            ],
          ],
        ),
      ),
    );
  }

  // Address Details Widget
  Widget _buildAddressDetails(AddressModel address) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectAddressScreen(
                enabled: true,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailRow(label: 'Street', value: address.streetAddress),
            DetailRow(label: 'City', value: address.city),
            DetailRow(label: 'State', value: address.state),
            DetailRow(label: 'Postal Code', value: address.postalCode),
          ],
        ),
      ),
    );
  }

  // Detail Row Helper

  // Service Options Widget
  Widget _buildServiceOptions(ServiceModel service) {
    return Column(
      children: service.subServices.map((subService) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedService = subService;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: _selectedService == subService
                  ? Colors.black12
                  : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: _selectedService == subService
                      ? Colors.black
                      : Colors.black12,
                  width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subService.name,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: _selectedService == subService
                              ? Colors.black
                              : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subService.discription,
                        style: GoogleFonts.montserrat(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      subService.price.toStringAsFixed(2),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: _selectedService == subService
                            ? Colors.black
                            : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subService.duration,
                      style: GoogleFonts.montserrat(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Date Picker Widget
  Widget _buildDatePicker() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.calendar_today, color: Colors.black),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)),
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.black,
                  ),
                ),
                child: child!,
              );
            },
          );
          if (picked != null && picked != _selectedDate) {
            setState(() {
              _selectedDate = picked;
            });
          }
        },
      ),
    );
  }

  // Time Slot Selection Widget
  Widget _buildTimeSlotSelection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _generateTimeSlots().length,
        itemBuilder: (context, index) {
          String timeSlot = _generateTimeSlots()[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeSlot = timeSlot;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: _selectedTimeSlot == timeSlot
                    ? Colors.black12
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: _selectedTimeSlot == timeSlot
                        ? Colors.black
                        : Colors.transparent,
                    width: 2),
              ),
              child: Center(
                child: Text(
                  timeSlot,
                  style: GoogleFonts.montserrat(
                    color: _selectedTimeSlot == timeSlot
                        ? Colors.black
                        : Colors.black87,
                    fontWeight: _selectedTimeSlot == timeSlot
                        ? FontWeight.w600
                        : FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Validation and Booking Method
  void _validateAndBook(bool hasRequiredData) {
    if (!hasRequiredData) {
      _showValidationError('Please add vehicle and address details');
      return;
    }

    if (_selectedService == null) {
      _showValidationError('Please select a charging service');
      return;
    }

    if (_selectedTimeSlot == null) {
      _showValidationError('Please select a time slot');
      return;
    }

    Razorpay razorpay = Razorpay();

    Map<String, Object> getTurboPaymentOptions() {
      return {
        "key": "rzp_test_KVEEmRUEiacNTK",
        "amount": (_selectedService!.price.toDouble() * 100).toString(),
        "name": "Fuel Delivery App",
        "description": "Total amount",
        "external": {
          "wallets": ["paytm"]
        }
      };
    }

    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      _showValidationError(
          "Payment Failed: ${response.message ?? 'Error occurred during payment'}");
    });

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) async {
      OrderCubit orderCubit = context.read<OrderCubit>();
      orderCubit.placeOrder(OrderModel(
        orderId: null,
        status: "Pending",
        paymentDone: true,
        payOnDelivery: false,
        address: selectedAddress!,
        vehicle: selectedVehicle!,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        serviceId: widget.service.id!,
        service: _selectedService!,
        deliveryDate: _selectedDate.toString(),
        deliveryTime: _selectedTimeSlot.toString(),
        totalAmount: _selectedService!.price,
        discountAmount: 12.0,
        paymentMethod: "Upi",
        paymentId: response.paymentId,
      ));
    });

    // final orderData = {
    //   "address": selectedAddress,
    //   'orderDate': _selectedDate.toString(),
    //   'timeSamp': DateTime.now().toString(),
    //   'orderId': response.orderId,
    //   'paymentId': response.paymentId,
    //   'signature': response.signature,
    //   'amount': _selectedService!.price,
    //   'timeSlot': _selectedTimeSlot,
    //   'service': widget.service.toJson(),
    //   'selectedService': _selectedService!.toJson(),
    //   'selectedVehicle': selectedVehicle!.toJson(),
    //   "orderStatus": "In Progress",
    //   'status': 'success',
    //   'userId': FireSetup.auth.currentUser?.uid,
    // };

    razorpay.open(getTurboPaymentOptions());
  }

  // Validation Error Dialog
  void _showValidationError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Booking Error',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        ),
        content: Text(
          message,
          style: GoogleFonts.montserrat(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: GoogleFonts.montserrat(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  const DetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              color: Colors.black54,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            width: 100,
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                value,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
