import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/screens/opening_section/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLoginPage();
  }

  // FUNCTION UNTUK MENAVIGASI KE HALAMAN SELANJUTNYA
  Future navigateToLoginPage() async {
    await Future.delayed(Duration(seconds: 5));
    Get.off(LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Image.asset(
            color: AppColors.primaryColor,
            "assets/diagnocare_logo1.png",
          ),
        ),
      ),
    );
  }
}
