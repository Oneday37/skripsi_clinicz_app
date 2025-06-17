import 'package:flutter/material.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(child: Text("Ini adalah Halaman Contact Us")),
    );
  }
}
