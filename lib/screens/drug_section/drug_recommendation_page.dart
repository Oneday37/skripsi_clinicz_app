import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/data/disease_exception_output_data.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drug_recommendation_detail_page.dart';
import 'package:skripsi_clinicz_app/screens/nearby_faskes_page.dart';
import 'package:skripsi_clinicz_app/services/ai_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';
import 'package:skripsi_clinicz_app/widgets/custom_navbar.dart';

class DrugRecommendationPage extends StatefulWidget {
  final String diseaseNameForDrug;
  const DrugRecommendationPage({super.key, required this.diseaseNameForDrug});

  @override
  State<DrugRecommendationPage> createState() => _DrugRecommendationPageState();
}

class _DrugRecommendationPageState extends State<DrugRecommendationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () {
            Get.off(CustomNavBar());
          },
        ),
        title: Text(
          "Rekomendasi Pengobatan",
          style: AppFonts().normalGreetingFontInside,
        ),
        centerTitle: true,
      ),
      // CONTAINER OF PREDICTION RESULT
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: AIServices().getDrugRecommendations(
            widget.diseaseNameForDrug,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      "assets/lottie_search_data_loading.json",
                    ),
                    Text("Harap Menunggu...", style: AppFonts().titleFont),
                    Text(
                      "Permintaan Anda Sedang diproses",
                      style: AppFonts().titleFont,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Terjadi kesalahan: ${snapshot.hasError}"),
              );
            } else if (diseaseExceptionOutput.contains(
              widget.diseaseNameForDrug,
            )) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pengobatan ${widget.diseaseNameForDrug} dianjurkan untuk berkonsultasi ke dokter terlebih dahulu",
                    style: GoogleFonts.oswald(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  CustomButtonInside(
                    label: "Deteksi Faskes Terdekat",
                    onTap: () => Get.to(NearbyFaskesPage()),
                  ),
                ],
              );
            } else {
              final getDrugData = snapshot.data;
              // LIST OF DRUG RECOMMENDATION
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  final getSingleDrugData = getDrugData![index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // NAME OF DRUG
                                  Text(
                                    getSingleDrugData.namaObat,
                                    style: AppFonts().subTitleFont,
                                  ),
                                  const SizedBox(height: 20),

                                  // DESCRIPTION OF DRUG
                                  Text(
                                    getSingleDrugData.deskripsiObat,
                                    style: AppFonts().normalBlackFont,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),

                            // PICTURE OF DRUG
                            Expanded(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      height:
                                          MediaQuery.of(context).size.width / 4,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      getSingleDrugData
                                          .deskripsiObat, // GANTI DENGAN GAMBAR
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  // DETAIL BUTTON
                                  GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.3,
                                            ),
                                            blurRadius: 5,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.info_outline,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Detail",
                                            style:
                                                AppFonts().normalWhiteBoldFont,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Get.to(
                                        DrugRecommendationDetailPage(
                                          drugName: getSingleDrugData.namaObat,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}
