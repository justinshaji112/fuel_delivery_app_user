import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Function(int) onChanged;

  QuantitySelector({required this.quantity, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove_circle_outline, size: 30),
          onPressed: () {
            if (quantity > 1) {
              onChanged(quantity - 1);
            }
          },
        ),
        Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              quantity.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outline, size: 30),
          onPressed: () {
            onChanged(quantity + 1);
          },
        ),
      ],
    );
  }
}