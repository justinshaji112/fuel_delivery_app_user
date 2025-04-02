import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final String subTitle;

  const AddressCard({
    super.key,
    required this.title,
    required this.icon,
    required this.subTitle,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        subTitle,
                        style: GoogleFonts.montserrat(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Icon(Icons.arrow_drop_down,
                        color: Colors.grey[600], size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}