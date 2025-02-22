import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/repository/profile_date_service.dart';
import 'package:fuel_delivery_app_user/models/vehicle_model.dart';
import 'package:fuel_delivery_app_user/view/pages/home/screens/add_vechile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuel_delivery_app_user/firebase_cofigarations.dart';

class VehicleSelectionPage extends StatefulWidget {
  const VehicleSelectionPage({super.key});

  @override
  _VehicleSelectionPageState createState() => _VehicleSelectionPageState();
}

class _VehicleSelectionPageState extends State<VehicleSelectionPage> {
  String? selectedVehicleId;
  final ProfileDateService _profileService = ProfileDateService();

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
          'Select Vehicle',
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
              onPressed: () => _navigateToAddVehicle(context),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text(
                'Add New Vehicle',
                style: GoogleFonts.montserrat(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<VehicleModel>>(
              stream: _profileService.getVehiclesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final vehicles = snapshot.data ?? [];

                if (vehicles.isEmpty) {
                  return const Center(child: Text('No vehicles found'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = vehicles[index];
                    final isSelected = index.toString() == selectedVehicleId;

                    return Card(
                      elevation: isSelected ? 4 : 1,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: isSelected ? Colors.black : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => _selectVehicle(index.toString()),
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
                                  vehicle.isElectric
                                      ? Icons.electric_car
                                      : Icons.directions_car,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${vehicle.make} ${vehicle.model}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${vehicle.year} · ${vehicle.type}${vehicle.isElectric ? ' · Electric' : ''}',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    if (vehicle.isElectric &&
                                        vehicle.batteryCapacity != null)
                                      Text(
                                        'Battery: ${vehicle.batteryCapacity} kWh',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.grey[600]),
                                onPressed: () => _editVehicle(context, vehicle),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.black,
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
          ),
          if (selectedVehicleId != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _continueWithSelectedVehicle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Continue',
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
    );
  }

  void _selectVehicle(String vehicleId) {
    setState(() {
      selectedVehicleId = vehicleId;
    });
  }

  void _navigateToAddVehicle(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddVehiclePage()),
    );
  }

  void _editVehicle(BuildContext context, VehicleModel vehicle) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddVehiclePage(vehicleToEdit: vehicle),
      ),
    );
  }

  void _continueWithSelectedVehicle() async {
    if (selectedVehicleId != null) {
      try {
        await FireSetup.users
            .doc(FireSetup.auth.currentUser!.uid)
            .update({"selectedVehicle": selectedVehicleId});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Address updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update address: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    Navigator.pop(context, selectedVehicleId);
  }
}

class VehicleCard extends StatelessWidget {
  final bool isSelected;
  final Widget child;

  const VehicleCard({
    super.key,
    required this.isSelected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
