import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/screens/prediction_page.dart/main_treatment.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';

class PredictionResult extends StatefulWidget {
  const PredictionResult({super.key});

  @override
  State<PredictionResult> createState() => _PredictionResultState();
}

class _PredictionResultState extends State<PredictionResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.thirdColor,
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
          style: TextStyle(color: AppColors.primaryColor),
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
                      "Migrain",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),

                    // DESCRIPTION OF DISEASE
                    Text(
                      "Migrain merupakan jenis sakit kepala yang terasa seperti berdenyut, dan umumnya hanya terjadi pada satu sisi kepala. Gejala sakit kepala lain yang sering menyertai migrain adalah rasa mual, muntah, pucat, rasa dingin pada ekstremitas, dan sensitif terhadap cahaya dan suara. Penyakit migrain biasanya akan mereda dalam kurun waktu 4 - 72 jam. Belum ada penyebab pasti mengapa seseorang mengalami penyakit migrain. Namun, penyakit ini dapat timbul melalui stress, kelelahan, mengkonsumsi makanan yang mengandung MSG, cokelat, keju.",
                      style: GoogleFonts.roboto(),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 50),

                    // ALERT MESSAGE !!!
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: "Note: ",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                "Untuk pemeriksaan lebih lanjut, diharapkan untuk menghubungi dokter",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
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
            SizedBox(height: 100),

            // BUTTON FOR GET MAIN TREATMENT
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButtonInside(
                label: "Rekomendasi Obat",
                onTap: () {
                  Get.to(MainTreatmentPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
