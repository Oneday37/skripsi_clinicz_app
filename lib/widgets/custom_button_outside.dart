import 'package:flutter/material.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';

class CustomButtonOutside extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const CustomButtonOutside({
    super.key,
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
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
