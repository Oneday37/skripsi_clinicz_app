import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProfile extends StatefulWidget {
  final String label;
  String content;
  CustomProfile({super.key, required this.label, required this.content});

  @override
  State<CustomProfile> createState() => _CustomProfileState();
}

class _CustomProfileState extends State<CustomProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              widget.content,
              style: GoogleFonts.roboto(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
