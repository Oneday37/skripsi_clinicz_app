import 'package:flutter/material.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';

class CustomButtonInside extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const CustomButtonInside({
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
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.bgColor,
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
