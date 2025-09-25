import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/data/about_us_Data.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Tentang Kami", style: AppFonts().titleFont),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              AboutUsData().introduction,
              style: AppFonts().normalBlackFont,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 30),
            Text("Fitur Aplikasi", style: AppFonts().subTitleFont),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                    // blurStyle: BlurStyle.inner,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  AboutUsData().featureApps,
                  style: AppFonts().normalBlackFont,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text("Teknologi Utama", style: AppFonts().subTitleFont),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                    // blurStyle: BlurStyle.inner,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  AboutUsData().coreTech,
                  style: AppFonts().normalBlackFont,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Container(height: 20),
          ],
        ),
      ),
    );
  }
}
