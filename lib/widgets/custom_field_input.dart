import 'package:flutter/material.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';

class CustomFieldInput extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final fieldIcon;
  const CustomFieldInput({
    super.key,
    required this.fieldIcon,
    required this.inputController,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      cursorColor: AppColors.primaryColor,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: fieldIcon,
        prefixIconColor: AppColors.iconColor,
        hintText: hintText,
        hintStyle: AppFonts().inputFieldFont,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
