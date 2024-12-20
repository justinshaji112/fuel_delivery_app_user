// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_delivery_app_user/core/data/datasources/get_fuel_price.dart';
import 'package:fuel_delivery_app_user/core/data/datasources/get_location_datasorce.dart';
import 'package:fuel_delivery_app_user/core/presentation/bloc/current_location/current_lcoation_bloc.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/order_page/order_summary_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:fuel_delivery_app_user/core/data/models/service_model.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/widgets/fuel_selection_sheet.dart';

class FuelDeliveryPage extends StatefulWidget {
  final ServiceModel serviceModel;
  const FuelDeliveryPage({
    Key? key,
    required this.serviceModel,
  }) : super(key: key);
  @override
  _FuelDeliveryPageState createState() => _FuelDeliveryPageState();
}

class _FuelDeliveryPageState extends State<FuelDeliveryPage> {

  String serviceType = "";
  Map<String, dynamic> serviceDetils = {};
  late GoogleMapController mapController;
  LatLng? _currentPosition;
  LatLng? _selectedPosition;
  Set<Marker> _markers = {};

  String selectedFuelType = 'petrol';
  int quantity = 10;
  double pricePerLiter = 1.5;
  String selectedPaymentMethod = 'Cash on Delivery';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _selectedPosition = _currentPosition;
      _updateMarkers();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_currentPosition != null) {
      mapController
          .animateCamera(CameraUpdate.newLatLngZoom(_currentPosition!, 15));
    }
  }

  void _updateMarkers() {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('selected_location'),
          position: _selectedPosition!,
          draggable: true,
          onDragEnd: (newPosition) {
            setState(() {
              _selectedPosition = newPosition;
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Delivery Location'),
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 15.0,
              ),
              markers: _markers,
              onTap: (LatLng position) {
                setState(() {
                  _selectedPosition = position;
                  _updateMarkers();
                });
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _selectedPosition == null
            ? null
            : () async{
              final address =await GetGeoLocation.getCurrentAddress(latlog: _selectedPosition);
                BlocProvider.of<CurrentLcoationBloc>(context).add(
                  ChangeLocationEvent(latLng: _selectedPosition!, address: address["address"])
                );
                widget.serviceModel.typeOfService.toLowerCase().startsWith("fu")
                    ? _showFuelSelectionSheet(context)
                    : Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderSummaryPage(
                          serviceModel:widget.serviceModel ,
                          price: [widget.serviceModel.finalPrice],
                          services: [widget.serviceModel.nameOfService],
                        ),
                      ));
              },
        label: Text('Confirm Location'),
        icon: Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showFuelSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return FuelSelectionSheet(
            selectedFuelType: selectedFuelType,
            quantity: quantity,
            onFuelTypeChanged: (newType) {
              setModalState(() => selectedFuelType = newType);
              setState(() => selectedFuelType = newType);
            },
            onQuantityChanged: (newQuantity) {
              setModalState(() => quantity = newQuantity);
              setState(() => quantity = newQuantity);
            },
            onProceed: () async {
              double price = 0.0;
              try {
                String fuelPrice =
                    await GetFuelPrice.getFuelPrice(selectedFuelType, "kerala");
                price = double.parse(fuelPrice);
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    OrderSummaryPage(serviceModel: widget.serviceModel,services: [serviceType], price: [price]),
              ));
            },
          );
        },
      ),
    );
  }
}
