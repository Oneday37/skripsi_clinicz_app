import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/medical_icon.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/history_prediction_section/detail_disease_prediction_history_page.dart';
import 'package:skripsi_clinicz_app/screens/history_prediction_section/detail_drug_recommendation_history_page.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_settings.dart';

class HistoryConclusionPage extends StatelessWidget {
  final String diseaseName;
  const HistoryConclusionPage({super.key, required this.diseaseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: Text(diseaseName, style: AppFonts().titleFont),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // DISEASE PREDICTION HISTORY AREA
            CustomFieldSettings(
              prefixIcon: Iconify(
                MedicalIcon.i_medical_library,
                color: Colors.white,
              ),
              label: "Riwayat Prediksi Penyakit",
              onTap: () {
                Get.to(DetailDiseasePredictionPage(diseaseName: diseaseName));
              },
            ),
            SizedBox(height: 20),

            // DRUG RECOMMENDATION HISTORY AREA
            CustomFieldSettings(
              prefixIcon: Iconify(Mdi.drugs, color: Colors.white),
              label: "Riwayat Rekomendasi Obat",
              onTap: () {
                Get.to(DetailDrugRecommendationPage(diseaseName: diseaseName));
              },
            ),
          ],
        ),
      ),
    );
  }
}
