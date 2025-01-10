import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/models/vehicle_model.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';


class AddVehiclePage extends StatefulWidget {
 VehicleModel ? vehicleToEdit;
  AddVehiclePage({super.key, this.vehicleToEdit});

  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final _formKey = GlobalKey<FormState>();

  // Vehicle Details Controllers
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _batteryCapacityController =
      TextEditingController();

  // Dropdown values
  String _selectedVehicleType = 'Car';
  String _selectedChargerType = 'Type 2 (Mennekes)';
  bool _isElectric = false;

  // Vehicle type options
  final List<String> _vehicleTypes = [
    'Car',
    'Motorcycle',
    'Truck',
    'Van',
    'SUV',
    'Pickup',
    'Scooter',
    'Bus',
    'RV'
  ];

  // Charger type options
  final List<String> _chargerTypes = [
    'Type 2 (Mennekes)',
    'CCS (Combined Charging System)',
    'CHAdeMO',
    'Tesla Connector',
    'Not Applicable'
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
          'Add Your Vehicle',
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
                  'Vehicle Details',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Electric Toggle
                _buildElectricToggle(),

                const SizedBox(height: 15),

                // Vehicle Type Dropdown
                _buildDropdownField(
                  label: 'Vehicle Type',
                  items: _vehicleTypes,
                  value: _selectedVehicleType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedVehicleType = newValue!;
                    });
                  },
                ),

                const SizedBox(height: 15),

                // Make Input
                _buildTextFormField(
                  controller: _makeController,
                  label: 'Make',
                  hint: 'e.g., Toyota, Honda, Tesla',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter vehicle make';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Model Input
                _buildTextFormField(
                  controller: _modelController,
                  label: 'Model',
                  hint: 'e.g., Camry, Civic, Model 3',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter vehicle model';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Year Input
                _buildTextFormField(
                  controller: _yearController,
                  label: 'Year',
                  hint: 'Manufacturing year',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter manufacturing year';
                    }
                    // Basic year validation
                    int? year = int.tryParse(value);
                    if (year == null ||
                        year < 1950 ||
                        year > DateTime.now().year) {
                      return 'Please enter a valid year';
                    }
                    return null;
                  },
                ),

                // Conditionally show battery capacity only for electric vehicles
                if (_isElectric) ...[
                  const SizedBox(height: 15),
                  _buildTextFormField(
                    controller: _batteryCapacityController,
                    label: 'Battery Capacity (kWh)',
                    hint: 'e.g., 75',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter battery capacity';
                      }
                      return null;
                    },
                  ),
                ],

                const SizedBox(height: 15),

                // Charger Type Dropdown (only for electric vehicles)
                if (_isElectric)
                  _buildDropdownField(
                    label: 'Preferred Charger Type',
                    items: _chargerTypes,
                    value: _selectedChargerType,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedChargerType = newValue!;
                      });
                    },
                  ),

                const SizedBox(height: 30),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: _submitVehicleDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Add Vehicle',
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
      ),
    );
  }

  // Electric Vehicle Toggle
  Widget _buildElectricToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12, width: 1.5),
      ),
      child: SwitchListTile(
        title: Text(
          'Is this an Electric Vehicle?',
          style: GoogleFonts.montserrat(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: _isElectric,
        onChanged: (bool value) {
          setState(() {
            _isElectric = value;
            // Reset charger type and battery capacity when switching
            if (!value) {
              _selectedChargerType = 'Not Applicable';
              _batteryCapacityController.clear();
            }
          });
        },
        activeColor: Colors.black,
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
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
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
            color: Colors.deepPurple,
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

  // Submit Vehicle Details Method
  void _submitVehicleDetails() async {
    if (_formKey.currentState!.validate()) {
      // Collect all vehicle details
      final vehicleDetails = {
        'type': _selectedVehicleType,
        'isElectric': _isElectric,
        'make': _makeController.text,
        'model': _modelController.text,
        'year': _yearController.text,
        'batteryCapacity': _isElectric ? _batteryCapacityController.text : null,
        'chargerType': _isElectric ? _selectedChargerType : null,
      };

      await FireSetup.profile.get().then((value) async {
        List<dynamic> existingAddresses = value.data()?['vehicles'] ?? [];
        existingAddresses.add(vehicleDetails);

        return await FireSetup.profile.update({"vehicles": existingAddresses});
      }).then(
        (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Address Added Successfully!',
                style: GoogleFonts.montserrat(),
              ),
              backgroundColor: Colors.green,
            ),
          );
        },
      ).onError(
        (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${error.toString()}!',
                style: GoogleFonts.montserrat(),
              ),
              backgroundColor: Colors.red,
            ),
          );
        },
      );

      // TODO: Implement your logic to save vehicle details
      // For now, we'll just print the details
      print('Vehicle Details: $vehicleDetails');

      // Optional: Show a success dialog or navigate to another page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vehicle Added Successfully!',
            style: GoogleFonts.montserrat(),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
