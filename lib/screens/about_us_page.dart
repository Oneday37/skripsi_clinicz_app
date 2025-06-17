import 'package:flutter/material.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(child: Text("Ini adalah Halaman About Us")),
    );
  }
}
