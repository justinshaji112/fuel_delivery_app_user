import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/core/presentation/models/services_model.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/methods/razor_pay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ServiceBookingPage extends StatefulWidget {
  final Service service;
  const ServiceBookingPage({super.key, required this.service});

  @override
  _ServiceBookingPageState createState() => _ServiceBookingPageState();
}

class _ServiceBookingPageState extends State<ServiceBookingPage> {
  // Selected Vehicle Details (Mock data - replace with actual data)
  final Map<String, dynamic> _selectedVehicle = {
    'make': 'Tesla',
    'model': 'Model 3',
    'year': '2022',
    'batteryCapacity': '75 kWh',
    'chargerType': 'Type 2'
  };

  // Selected Address Details (Mock data - replace with actual data)
  final Map<String, dynamic> _selectedAddress = {
    'street': '123 Electric Avenue',
    'city': 'Tech City',
    'state': 'CA',
    'postalCode': '94000'
  };

  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;
  SubService? _selectedService;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle Details Section
              _buildSectionHeader('Selected Vehicle'),
              _buildVehicleDetails(),

              const SizedBox(height: 20),

              // Address Details Section
              _buildSectionHeader(' Location'),
              _buildAddressDetails(),

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
                  onPressed: _validateAndBook,
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
  Widget _buildVehicleDetails() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Make', _selectedVehicle['make']),
          _buildDetailRow('Model', _selectedVehicle['model']),
          _buildDetailRow('Year', _selectedVehicle['year']),
          _buildDetailRow(
              'Battery Capacity', _selectedVehicle['batteryCapacity']),
          _buildDetailRow('Charger Type', _selectedVehicle['chargerType']),
        ],
      ),
    );
  }

  // Address Details Widget
  Widget _buildAddressDetails() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Street', _selectedAddress['street']),
          _buildDetailRow('City', _selectedAddress['city']),
          _buildDetailRow('State', _selectedAddress['state']),
          _buildDetailRow('Postal Code', _selectedAddress['postalCode']),
        ],
      ),
    );
  }

  // Detail Row Helper
  Widget _buildDetailRow(String label, String value) {
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
          ),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Service Options Widget
  Widget _buildServiceOptions(Service service) {
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
              color:
                  _selectedService == subService ? Colors.black12 : Colors.white,
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
                      '${subService.price.toStringAsFixed(2)}',
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
  void _validateAndBook() {
    if (_selectedService == null) {
      _showValidationError('Please select a charging service');
      return;
    }

    if (_selectedTimeSlot == null) {
      _showValidationError('Please select a time slot');
      return;
    }
    OnlinePayment.showRazorPaySheet(_selectedService!.price.toDouble(), "Total amount");
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