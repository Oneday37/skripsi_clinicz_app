import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/medical_icon.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/history_prediction_section/detail_disease_prediction_history_page.dart';
import 'package:skripsi_clinicz_app/screens/history_prediction_section/detail_drug_recommendation_history_page.dart';
import 'package:skripsi_clinicz_app/screens/history_prediction_section/symptoms_user_input_history_page.dart';
import 'package:skripsi_clinicz_app/services/history_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_settings.dart';

class HistoryConclusionPage extends StatelessWidget {
  final String diseaseName;
  final int index;
  const HistoryConclusionPage({
    super.key,
    required this.diseaseName,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: Text(
          "Detail History Prediksi $diseaseName",
          style: AppFonts().titleFont,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // SYMPTOMS HISTORY AREA
            FutureBuilder(
              future: HistoryServices().getHistoryPrediction(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CustomFieldSettings(
                    prefixIcon: Iconify(Mdi.face_sick_outline),
                    label: "History Gejala",
                    onTap: () {},
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  final getDataPrediction = snapshot.data![index];
                  return CustomFieldSettings(
                    prefixIcon: Iconify(Mdi.face_sick_outline),
                    label: "History Gejala",
                    onTap: () {
                      Get.to(
                        SymptomsUserInputPage(
                          getDataID: getDataPrediction.id,
                          diseaseName: diseaseName,
                        ),
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(height: 20),

            // DISEASE PREDICTION HISTORY AREA
            FutureBuilder(
              future: HistoryServices().getHistoryPrediction(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CustomFieldSettings(
                    prefixIcon: Iconify(MedicalIcon.i_medical_library),
                    label: "Prediksi Penyakit",
                    onTap: () {},
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  final getDiseasePredictionHistory = snapshot.data![index];
                  return CustomFieldSettings(
                    prefixIcon: Iconify(MedicalIcon.i_medical_library),
                    label: "Prediksi Penyakit",
                    onTap: () {
                      Get.to(
                        DetailDiseasePredictionPage(
                          getDataID: getDiseasePredictionHistory.id,
                          diseaseName: diseaseName,
                        ),
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(height: 20),

            // DRUG RECOMMENDATION HISTORY AREA
            FutureBuilder(
              future: HistoryServices().getPredictionResult(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CustomFieldSettings(
                    prefixIcon: Iconify(Mdi.drugs),
                    label: "Rekomendasi Obat",
                    onTap: () {},
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  final getDrugRecommendationHistory = snapshot.data![index];
                  return CustomFieldSettings(
                    prefixIcon: Iconify(Mdi.drugs),
                    label: "Rekomendasi Obat",
                    onTap: () {
                      Get.to(
                        DetailDrugRecommendationPage(
                          getDataID: getDrugRecommendationHistory.id,
                          diseaseName: diseaseName,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
