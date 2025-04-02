import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopServicesWidget extends StatelessWidget {
  const TopServicesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> topServices = [
      {'name': 'Quick Repair', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Emergency', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Maintenance', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Diagnostics', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Towing', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Cleaning', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Parts', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Insurance', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Booking', 'image': 'assets/images/11-2-car-picture.png'},
      {'name': 'Support', 'image': 'assets/images/11-2-car-picture.png'},
    ];

    return SizedBox(
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topServices.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              width: 85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: Image.asset(
                      topServices[index]['image'],
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    topServices[index]['name'],
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}