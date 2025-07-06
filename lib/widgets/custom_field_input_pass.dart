import 'package:flutter/material.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';

class CustomFieldInputPass extends StatefulWidget {
  final TextEditingController inputController;
  final String hintText;
  const CustomFieldInputPass({
    super.key,
    required this.inputController,
    required this.hintText,
  });

  @override
  State<CustomFieldInputPass> createState() => _CustomFieldInputPassState();
}

class _CustomFieldInputPassState extends State<CustomFieldInputPass> {
  bool visibilityButton = true;

  void visibilityPass() {
    setState(() {
      visibilityButton = !visibilityButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.inputController,
      cursorColor: AppColors.primaryColor,
      obscureText: visibilityButton == true ? true : false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        prefixIconColor: AppColors.iconColor,
        hintText: widget.hintText,
        hintStyle: AppFonts().inputFieldFont,
        suffixIcon: GestureDetector(
          child:
              visibilityButton == true
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
          onTap: () {
            visibilityPass();
          },
        ),
        suffixIconColor: AppColors.iconColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
