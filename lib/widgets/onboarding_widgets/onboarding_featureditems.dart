import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureListItem extends StatelessWidget {
  final IconData icon;
  final String description;

  const FeatureListItem(
      {super.key, required this.icon, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
          const SizedBox(width: 10.0),
          Container(
            color: Colors.black.withOpacity(0.6),
            child: Text(
              description,
              style: GoogleFonts.aBeeZee(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
