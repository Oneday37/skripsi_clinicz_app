import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/screens/prediction_section/prediction_result_page.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';

class PredictionDiseasePage extends StatefulWidget {
  const PredictionDiseasePage({super.key});

  @override
  State<PredictionDiseasePage> createState() => _PredictionDiseasePageState();
}

class _PredictionDiseasePageState extends State<PredictionDiseasePage> {
  TextEditingController gejalaController = TextEditingController();
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
          "Prediksi Penyakit",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                // APPLICATION LOGO
                AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Image.asset("assets/clinicz_logo_2.png"),
                ),
                Text("Prediksi Penyakitmu Sekarang !"),
                SizedBox(height: 50),

                // DISEASE PREDICTION SECTION
                Text(
                  "Tuliskan gejala anda secara spesifik yang sedang anda alami!",
                ),
                SizedBox(height: 20),

                // CONTAINER FOR ENTERING SYMPTOMS OF DISEASE
                TextFormField(
                  controller: gejalaController,
                  textAlign: TextAlign.justify,
                  maxLines: 4,
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 70),

                // ANALYSIS BUTTON FOR GET DISEASE FROM USER INPUT
                CustomButtonInside(
                  label: "Analisis",
                  onTap: () {
                    Get.to(PredictionResult());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
