import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';

class DetailDiseasePredictionPage extends StatefulWidget {
  const DetailDiseasePredictionPage({super.key});

  @override
  State<DetailDiseasePredictionPage> createState() =>
      _DetailDiseasePredictionPageState();
}

class _DetailDiseasePredictionPageState
    extends State<DetailDiseasePredictionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.thirdColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Nama Penyakit", style: AppFonts().titleFont),
        centerTitle: true,
      ),

      // CONTAINER OF PREDICTION RESULT
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Deskripsi Penyakit", style: AppFonts().subTitleFont),
                SizedBox(height: 10),

                // DESCRIPTION OF DISEASE
                Text(
                  AppDummyText().dummyDiseaseDesc,
                  style: AppFonts().normalBlackFont,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30),

                Text("Penyebab", style: AppFonts().subTitleFont),
                SizedBox(height: 10),

                // CAUSE OF DISEASE
                Text(
                  AppDummyText().dummyDiseaseCause,
                  style: AppFonts().normalBlackFont,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30),

                Text("Pencegahan", style: AppFonts().subTitleFont),
                SizedBox(height: 10),

                // PREVENTION OF DISEASE
                Text(
                  AppDummyText().dummyDiseasePrevention,
                  style: AppFonts().normalBlackFont,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 40),

                // ALERT MESSAGE !!!
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: "Note: ",
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "Untuk pemeriksaan lebih lanjut, diharapkan untuk menghubungi dokter",
                        style: GoogleFonts.robotoCondensed(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),

                // SOURCE OF DATA
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: "Sumber: ",
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: AppDummyText().dummyDiseaseource,
                        style: GoogleFonts.robotoCondensed(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
