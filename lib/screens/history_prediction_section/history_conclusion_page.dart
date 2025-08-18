import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/medical_icon.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_settings.dart';

class HistoryConclusionPage extends StatelessWidget {
  final String diseaseName;
  // final dynamic diseaseID;
  // final dynamic drugID;
  const HistoryConclusionPage({
    super.key,
    required this.diseaseName,
    // required this.diseaseID,
    // required this.drugID,
  });

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
            // SYMPTOMS HISTORY AREA
            CustomFieldSettings(
              prefixIcon: Iconify(Mdi.face_sick_outline, color: Colors.white),
              label: "History Gejala",
              onTap: () {
                // Get.to(
                //   SymptomsUserInputPage(
                //     getDataID: diseaseID,
                //     diseaseName: diseaseName,
                //   ),
                // );
              },
            ),
            SizedBox(height: 20),

            // DISEASE PREDICTION HISTORY AREA
            CustomFieldSettings(
              prefixIcon: Iconify(
                MedicalIcon.i_medical_library,
                color: Colors.white,
              ),
              label: "Prediksi Penyakit",
              onTap: () {
                // Get.to(
                //   DetailDiseasePredictionPage(
                //     getDataID: diseaseID,
                //     diseaseName: diseaseName,
                //   ),
                // );
              },
            ),
            SizedBox(height: 20),

            // DRUG RECOMMENDATION HISTORY AREA
            CustomFieldSettings(
              prefixIcon: Iconify(Mdi.drugs, color: Colors.white),
              label: "Rekomendasi Obat",
              onTap: () {
                // Get.to(
                //   DetailDrugRecommendationPage(
                //     getDataID: drugID,
                //     diseaseName: diseaseName,
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
