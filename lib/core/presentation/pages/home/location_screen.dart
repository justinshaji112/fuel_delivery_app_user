import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class SelectLocationPage extends StatefulWidget {
  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  GoogleMapController? _mapController;
  TextEditingController _searchController = TextEditingController();
  LatLng _selectedLocation = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Implement search functionality
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _selectedLocation,
                zoom: 14.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              onTap: (LatLng latLng) {
                setState(() {
                  _selectedLocation = latLng;
                });
              },
              markers: {
                Marker(
                  markerId: MarkerId('selected_location'),
                  position: _selectedLocation,
                ),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('Confirm Location'),
              onPressed: () {
                // Handle location confirmation
                Navigator.pop(context, _selectedLocation);
              },
            ),
          ),
        ],
      ),
    );
  }
}