import 'package:flutter/material.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';

class CustomDetailDrug extends StatefulWidget {
  final String label;
  final String content;
  const CustomDetailDrug({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  State<CustomDetailDrug> createState() => _CustomDetailDrugState();
}

class _CustomDetailDrugState extends State<CustomDetailDrug> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppFonts().subTitleFont),
        SizedBox(height: 10),
        Text(
          widget.content,
          style: AppFonts().normalBlackFont,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
