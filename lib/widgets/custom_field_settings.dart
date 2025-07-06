import 'package:flutter/material.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';

class CustomFieldSettings extends StatelessWidget {
  final dynamic prefixIcon;
  final String label;
  final VoidCallback onTap;
  CustomFieldSettings({
    super.key,
    required this.prefixIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              prefixIcon,
              SizedBox(width: 20),
              Expanded(child: Text(label, style: AppFonts().normalWhiteFont)),
              Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
