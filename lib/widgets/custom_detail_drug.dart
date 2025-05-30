import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDetailDrug extends StatefulWidget {
  final String label;
  String content;
  CustomDetailDrug({super.key, required this.label, required this.content});

  @override
  State<CustomDetailDrug> createState() => _CustomDetailDrugState();
}

class _CustomDetailDrugState extends State<CustomDetailDrug> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        Text(widget.content, textAlign: TextAlign.justify),
      ],
    );
  }
}
