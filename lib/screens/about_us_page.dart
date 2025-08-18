import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/services/setting_service.dart';

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
      body: FutureBuilder(
        future: SettingService().getAboutUsContent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset("assets/lottie_loading_animation.json"),
                Text("Sedang memuat profile...", style: AppFonts().titleFont),
              ],
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Gagal memuat data profil'));
          } else {
            // Buang <h1>...</h1> dan <hr> dari HTML
            final rawData = snapshot.data ?? '';
            final filteredData = rawData
                .replaceAll(RegExp(r'<h1[^>]*>.*?<\/h1>', dotAll: true), '')
                .replaceAll(RegExp(r'<hr[^>]*>', dotAll: true), '');

            return ListView(
              children: [
                Html(
                  data: filteredData,
                  style: {
                    "body": Style(
                      margin: Margins(top: Margin.zero()),

                      padding: HtmlPaddings.symmetric(vertical: 0),
                    ),
                    'h1': Style(fontSize: FontSize(50)),
                    "strong": Style(fontWeight: FontWeight.bold),
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
