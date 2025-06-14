import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/la.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/widgets/custom_detail_drug.dart';

class DrugDetailShopPage extends StatefulWidget {
  const DrugDetailShopPage({super.key});

  @override
  State<DrugDetailShopPage> createState() => _DrugDetailShopPageState();
}

class _DrugDetailShopPageState extends State<DrugDetailShopPage> {
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
            SizedBox(height: 30),

            // DESCRIPTION OF TREATMENT
            CustomDetailDrug(
              label: "Deskripsi Obat:",
              content: AppDummyText().dummyDrugDesc,
            ),
            SizedBox(height: 30),

            // MEDICINE INGREDIENTS
            CustomDetailDrug(
              label: "Kandungan:",
              content: AppDummyText().dummyDrugIngredients,
            ),
            SizedBox(height: 30),

            // TREATMENT DOSAGE
            CustomDetailDrug(
              label: "Dosis Penggunaan:",
              content: AppDummyText().dummyDrugDosage,
            ),
            SizedBox(height: 30),

            // TERMS OF USE
            CustomDetailDrug(
              label: "Aturan Pakai:",
              content: AppDummyText().dummyDrugTermsofUse,
            ),
            SizedBox(height: 30),

            Text("Obat yang serupa", style: AppFonts().subTitleFont),
            SizedBox(height: 5),

            // LIST OF DRUG RECOMMENDATION
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Padding(
                      padding:
                          index == 1
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
                                Text(
                                  AppDummyText().dummyDrugTitle,
                                  style: AppFonts().normalBlackFont,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              AppDummyText().dummyDrugDesc,
                              style: AppFonts().normalBlackFont,
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
            SizedBox(height: 40),

            // BUTTON FOR REDIRECT SHOP
            GestureDetector(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Go To Market",
                          style: AppFonts().normalWhiteBoldFont,
                        ),
                      ),
                      Iconify(La.shopping_cart, size: 35, color: Colors.white),
                    ],
                  ),
                ),
              ),
              onTap: () {
                print(
                  "Anda menekan button Go To Market yang akan mengarahkan anda ke link toko online",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
