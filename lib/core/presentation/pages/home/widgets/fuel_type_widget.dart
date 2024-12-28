import 'package:flutter/material.dart';

class FuelTypeWidget extends StatelessWidget {
  final String type;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  FuelTypeWidget({
    required this.type,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 40,
                color: isSelected ? Colors.white : Colors.black,
              ),
              SizedBox(height: 10),
              Text(
                type,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}