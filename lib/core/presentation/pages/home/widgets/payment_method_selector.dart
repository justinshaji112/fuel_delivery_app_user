import 'package:flutter/material.dart';

class PaymentMethodSelector extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onChanged;

  PaymentMethodSelector(
      {required this.selectedMethod, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          title: Text('Cash on Delivery'),
          value: 'Cash on Delivery',
          groupValue: selectedMethod,
          onChanged: (value) => onChanged(value as String),
        ),
        RadioListTile(
          title: Text('UPI'),
          value: 'UPI',
          groupValue: selectedMethod,
          onChanged: (value) => onChanged(value as String),
        ),
      ],
    );
  }
}