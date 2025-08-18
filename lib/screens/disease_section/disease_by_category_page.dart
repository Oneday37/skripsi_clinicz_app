import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/disease_section/detail_disease_by_category_page.dart';
import 'package:skripsi_clinicz_app/services/disease_service.dart';

class DiseaseByCategoryPage extends StatelessWidget {
  final String diseaseCategory;
  const DiseaseByCategoryPage({super.key, required this.diseaseCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: Text("List $diseaseCategory"),
      ),
      body: FutureBuilder(
        future: DiseaseService().getDiseaseByCategroy(diseaseCategory),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      "assets/lottie_search_data_loading.json",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Sedang mengambil data ...",
                      style: AppFonts().titleFont,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Data obat tidak tersedia."));
          } else {
            final getDataDisease = snapshot.data!;
            getDataDisease.sort(
              (a, b) => a.namaPenyakit.compareTo(b.namaPenyakit),
            );
            return ListView.builder(
              itemCount: getDataDisease.length,
              itemBuilder: (context, index) {
                final getSingleDataDisease = getDataDisease[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
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
                            getSingleDataDisease.namaPenyakit,
                            style: AppFonts().subTitleFont,
                          ),
                          const SizedBox(height: 20),

                          // DESCRIPTION OF DISEASE
                          Text(
                            getSingleDataDisease.deskripsiPenyakit,
                            style: AppFonts().normalBlackFont,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black),
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
                                  child: Text(
                                    "# ${getSingleDataDisease.kategoriPenyakit}",
                                    style: AppFonts().normalBlackTagFont,
                                  ),
                                ),
                              ),
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
                                    child: Text(
                                      "Detail",
                                      style: AppFonts().normalWhiteBoldFont,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Get.to(
                                    DetailDiseaseByCategoryPage(
                                      diseaseName:
                                          getSingleDataDisease.namaPenyakit,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
