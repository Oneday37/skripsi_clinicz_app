import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/models/disease_prediction_model.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drug_recommendation_page.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';

class PredictionResultPage extends StatelessWidget {
  final PenyakitPrediction prediction;
  const PredictionResultPage({super.key, required this.prediction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.thirdColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Hasil Prediksi", style: AppFonts().titleFont),
        centerTitle: true,
      ),

      // CONTAINER OF PREDICTION RESULT
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.thirdColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NAME OF DISEASE
                    Text(prediction.penyakit, style: AppFonts().subTitleFont),
                    SizedBox(height: 10),

                    // DESCRIPTION OF DISEASE
                    Text(
                      prediction.deskripsi,
                      style: AppFonts().normalBlackFont,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 30),

                    Text("Penyebab", style: AppFonts().subTitleFont),
                    SizedBox(height: 10),

                    // CAUSE OF DISEASE
                    Text(
                      prediction.penyebab,
                      style: AppFonts().normalBlackFont,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 30),

                    Text("Pencegahan", style: AppFonts().subTitleFont),
                    SizedBox(height: 10),

                    // PREVENTION OF DISEASE
                    Text(
                      prediction.pencegahan,
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
              ),
            ),

            SizedBox(height: 50),

            // BUTTON FOR GET MAIN TREATMENT
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButtonInside(
                label: "Rekomendasi Obat",
                onTap: () {
                  Get.to(DrugRecommendationPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
