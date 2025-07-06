import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/models/disease_prediction_model.dart';
import 'package:skripsi_clinicz_app/screens/prediction_section/prediction_disease_detail_page.dart';

class PredictionResultPage extends StatefulWidget {
  final DiseasePredictionModel prediction;
  const PredictionResultPage({super.key, required this.prediction});

  @override
  State<PredictionResultPage> createState() => _PredictionResultPageState();
}

class _PredictionResultPageState extends State<PredictionResultPage> {
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
        title: Text(
          "Hasil Prediksi",
          style: AppFonts().normalGreetingFontInside,
        ),
        centerTitle: true,
      ),

      // CONTAINER OF PREDICTION RESULT
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // NAME OF DISEASE
                Text(
                  widget.prediction.penyakit,
                  style: AppFonts().subTitleFont,
                ),
                const SizedBox(height: 20),

                // DESCRIPTION OF DISEASE
                Text(
                  widget.prediction.deskripsi,
                  style: AppFonts().normalBlackFont,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.info_outline, color: Colors.white),
                          SizedBox(width: 10),
                          Text("Detail", style: AppFonts().normalWhiteBoldFont),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(
                      PredictionDiseaseDetailPage(
                        prediction: widget.prediction,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
