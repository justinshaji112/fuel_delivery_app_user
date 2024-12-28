import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/widgets/fuel_type_widget.dart';
import 'package:fuel_delivery_app_user/core/presentation/pages/home/widgets/quantity_selector.dart';

class FuelSelectionSheet extends StatelessWidget {
  final String selectedFuelType;
  final int quantity;
  final Function(String) onFuelTypeChanged;
  final Function(int) onQuantityChanged;
  final VoidCallback onProceed;

  FuelSelectionSheet({
    required this.selectedFuelType,
    required this.quantity,
    required this.onFuelTypeChanged,
    required this.onQuantityChanged,
    required this.onProceed,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.2,
      maxChildSize: 0.75,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10),
            ],
          ),
          child: ListView(
            controller: controller,
            padding: EdgeInsets.all(20),
            children: [
              Text(
                'Select Fuel Type',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  FuelTypeWidget(
                    type: 'Diesel',
                    icon: Icons.local_gas_station,
                    isSelected: selectedFuelType == 'Diesel',
                    onTap: () => onFuelTypeChanged('Diesel'),
                  ),
                  SizedBox(width: 10),
                  FuelTypeWidget(
                    type: 'Petrol',
                    icon: Icons.local_gas_station,
                    isSelected: selectedFuelType == 'Petrol',
                    onTap: () => onFuelTypeChanged('Petrol'),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Select Quantity (Liters)',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              QuantitySelector(
                quantity: quantity,
                onChanged: onQuantityChanged,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: onProceed,
                child: Text('Proceed to Order'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}