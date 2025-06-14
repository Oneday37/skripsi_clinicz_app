import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/data/disease_category.dart';
import 'package:skripsi_clinicz_app/drug_section/drug_detail_shop_page.dart';
import 'package:skripsi_clinicz_app/models/disease_category_model.dart';

class DrugShopPage extends StatefulWidget {
  const DrugShopPage({super.key});

  @override
  State<DrugShopPage> createState() => _DrugShopPageState();
}

class _DrugShopPageState extends State<DrugShopPage> {
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
          "DiagnoCare Shop",
          style: AppFonts().normalGreetingFontInside,
        ),
        actions: [Image.asset("assets/clinicz_logo_2.png")],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              "Cari obat kamu berdasarkan kategori penyakit",
              style: AppFonts().subTitleFont,
            ),
            SizedBox(height: 20),

            // AREA FOR DISEASE CATEGORY
            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: diseaseCategory.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  DiseaseCategoryModel getDiseaseCategory =
                      diseaseCategory[index];
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          child: Center(
                            child: Text(
                              getDiseaseCategory.diseaseName,
                              style: AppFonts().normalWhiteBoldFont,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      // NANTI UBAH KETIKA MEMILIH MAKA ITEM DIBAWAHNYA IKUT BERUBAH
                      print(
                        "Anda menekan menu ${getDiseaseCategory.diseaseName}",
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            // LIST OF DRUGS
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: 10,
              itemBuilder: (_, index) {
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: AspectRatio(
                              aspectRatio: 4 / 3,
                              child: Image.asset(
                                "assets/drug_sample.png",
                                // fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              AppDummyText().dummyDrugTitle,
                              style: AppFonts().normalWhiteBoldFont,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(DrugDetailShopPage());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
