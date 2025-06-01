import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/widgets/custom_detail_drug.dart';

class DetailTreatment extends StatefulWidget {
  const DetailTreatment({super.key});

  @override
  State<DetailTreatment> createState() => _DetailTreatmentState();
}

class _DetailTreatmentState extends State<DetailTreatment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
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

        // NAME OF DISEASE
        title: Text(
          AppDummyText().dummyDrugTitle,
          style: TextStyle(color: AppColors.primaryColor),
        ),
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
            SizedBox(height: 50),

            Text(
              "Obat yang serupa",
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),

            // LIST OF DRUG RECOMMENDATION
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Padding(
                      padding:
                          index == 3
                              ? const EdgeInsets.all(0)
                              : const EdgeInsets.only(right: 20),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 250,
                        decoration: BoxDecoration(
                          color: AppColors.thirdColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/drug_sample.png",
                                  fit: BoxFit.cover,
                                  scale: 2.5,
                                ),
                                // SizedBox(width: 10),
                                Text(AppDummyText().dummyDrugTitle),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              AppDummyText().dummyDrugDesc,
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      print("Anda menekan rekomendasi obet ke-$index");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
