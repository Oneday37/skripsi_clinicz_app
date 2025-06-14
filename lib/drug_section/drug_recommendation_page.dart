import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';

class DrugRecommendationPage extends StatefulWidget {
  const DrugRecommendationPage({super.key});

  @override
  State<DrugRecommendationPage> createState() => _DrugRecommendationPageState();
}

class _DrugRecommendationPageState extends State<DrugRecommendationPage> {
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
        title: Text("Rekomendasi Pengobatan", style: AppFonts().titleFont),
        centerTitle: true,
      ),
      // CONTAINER OF PREDICTION RESULT
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.width / 2,
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
                        AppDummyText().dummyDrugTitle,
                        style: AppFonts().subTitleFont,
                      ),
                      SizedBox(height: 20),

                      // DESCRIPTION OF DISEASE
                      Text(
                        AppDummyText().dummyDrugDesc,
                        style: AppFonts().normalBlackFont,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text("Obat yang Serupa", style: AppFonts().subTitleFont),
              SizedBox(height: 10),

              // LIST OF DRUG RECOMMENDATION
              SizedBox(
                height: MediaQuery.of(context).size.width / 2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      child: Padding(
                        padding:
                            index == 4
                                ? const EdgeInsets.all(0)
                                : const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: AppColors.thirdColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // NAME OF DISEASE
                                Text(
                                  AppDummyText().dummyDrugTitle,
                                  style: AppFonts().subTitleFont,
                                ),
                                SizedBox(height: 20),

                                // DESCRIPTION OF DISEASE
                                Text(
                                  AppDummyText().dummyDrugDesc,
                                  style: AppFonts().normalBlackFont,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(DrugRecommendationPage());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          onTap: () {
            Get.to(DrugRecommendationPage());
          },
        ),
      ),
    );
  }
}
