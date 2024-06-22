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
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.black,
            ),
            Text(
              description,
              style: GoogleFonts.aBeeZee(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
