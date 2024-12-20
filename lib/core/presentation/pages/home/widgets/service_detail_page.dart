import 'package:flutter/material.dart';

class ServiceDetailsSheet extends StatelessWidget {
  final String serviceType;
  final Map<String, dynamic> serviceDetails;
  final VoidCallback onProceed;

  ServiceDetailsSheet({
    required this.serviceType,
    required this.serviceDetails,
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
                'Service Details: $serviceType',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Display service details
              ...serviceDetails.entries.map((entry) => _buildDetailRow(entry.key, entry.value.toString())),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}