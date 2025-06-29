import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/models/disease_prediction_model.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drug_recommendation_page.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';

class PredictionResultPage extends StatefulWidget {
  final DiseasePredictionModel prediction;
  const PredictionResultPage({super.key, required this.prediction});

  @override
  State<PredictionResultPage> createState() => _PredictionResultPageState();
}

class _PredictionResultPageState extends State<PredictionResultPage> {
  bool isLoading = false;

  void drugRecommendationSHandler() async {
    if (mounted) {
      Get.to(DrugRecommendationPage(diseaseName: widget.prediction.penyakit));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal mendapatkan hasil prediksi.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Hasil Prediksi",
          style: AppFonts().normalGreetingFontInside,
        ),
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
                    Text(
                      widget.prediction.penyakit,
                      style: AppFonts().subTitleFont,
                    ),
                    SizedBox(height: 10),

                    // DESCRIPTION OF DISEASE
                    Text(
                      widget.prediction.deskripsi,
                      style: AppFonts().normalBlackFont,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 30),

                    Text("Penyebab", style: AppFonts().subTitleFont),
                    SizedBox(height: 10),

                    // CAUSE OF DISEASE
                    Text(
                      widget.prediction.penyebab,
                      style: AppFonts().normalBlackFont,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 30),

                    Text("Pencegahan", style: AppFonts().subTitleFont),
                    SizedBox(height: 10),

                    // PREVENTION OF DISEASE
                    Text(
                      widget.prediction.pencegahan,
                      style: AppFonts().normalBlackFont,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 40),

                    // ALERT MESSAGE !!!
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: "Note: ",
                        style: AppFonts().normalBlackBoldFont,
                        children: [
                          TextSpan(
                            text:
                                "Untuk pemeriksaan lebih lanjut, diharapkan untuk menghubungi dokter",
                            style: AppFonts().normalBlackFont,
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
                        style: AppFonts().normalBlackBoldFont,
                        children: [
                          TextSpan(
                            text: widget.prediction.sumber,
                            style: AppFonts().normalBlackFont,
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
            isLoading
                ? Center(
                  child: Column(
                    children: [
                      LottieBuilder.network(
                        "https://lottie.host/7b7b708d-3fe5-45dc-91c5-8734b83d4ac9/UN9GvQGgBM.json",
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Harap menunggu ...",
                        style: AppFonts().normalBlackFont,
                      ),
                    ],
                  ),
                )
                : CustomButtonInside(
                  label: "Dapatkan Pengobatan",
                  onTap: () {
                    drugRecommendationSHandler();
                  },
                ),
          ],
        ),
      ),
    );
  }
}
