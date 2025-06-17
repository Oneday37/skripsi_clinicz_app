import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/widgets/custom_detail_drug.dart';

class DrugRecommendationDetailPage extends StatefulWidget {
  const DrugRecommendationDetailPage({super.key});

  @override
  State<DrugRecommendationDetailPage> createState() =>
      _DrugRecommendationDetailPageState();
}

class _DrugRecommendationDetailPageState
    extends State<DrugRecommendationDetailPage> {
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

        // NAME OF DISEASE
        title: Text(AppDummyText().dummyDrugTitle, style: AppFonts().titleFont),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // CONTAINER FOR IMAGE
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset("assets/drug_sample.png"),
            ),
            SizedBox(height: 20),

            // DESCRIPTION OF TREATMENT
            CustomDetailDrug(
              label: "Deskripsi Obat:",
              content: AppDummyText().dummyDrugDesc,
            ),
            SizedBox(height: 20),

            // MEDICINE INGREDIENTS
            CustomDetailDrug(
              label: "Kandungan:",
              content: AppDummyText().dummyDrugIngredients,
            ),
            SizedBox(height: 20),

            // TREATMENT DOSAGE
            CustomDetailDrug(
              label: "Dosis Penggunaan:",
              content: AppDummyText().dummyDrugDosage,
            ),
            SizedBox(height: 20),

            // TERMS OF USE
            CustomDetailDrug(
              label: "Aturan Pakai:",
              content: AppDummyText().dummyDrugTermsofUse,
            ),
          ],
        ),
      ),
    );
  }
}
