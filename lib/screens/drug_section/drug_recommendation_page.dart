import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drug_detail_shop_page.dart';
import 'package:skripsi_clinicz_app/services/ai_services.dart';

class DrugRecommendationPage extends StatefulWidget {
  final String diseaseName;
  const DrugRecommendationPage({super.key, required this.diseaseName});

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
            Get.back();
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
          future: AIServices().getDrugRecommendations(widget.diseaseName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.network(
                      "https://lottie.host/773ae2e1-0078-4f47-bc1b-fcf247e8224a/Xm3svCgTAm.json",
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
            } else if (widget.diseaseName == "Hepatitis") {
              return Center(
                child: Text(
                  "Pengobatan Hepatits bergantung pada jenis hepatitis yang diderita ${snapshot.data!.first.pesan}",
                  style: GoogleFonts.oswald(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              final getData = snapshot.data;
              return ListView.builder(
                itemCount: getData!.length,
                itemBuilder: (context, index) {
                  final getSingleDataDrug = getData[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      child: Container(
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
                                getSingleDataDrug.namaObat,
                                style: AppFonts().subTitleFont,
                              ),
                              SizedBox(height: 20),

                              // DESCRIPTION OF DISEASE
                              Text(
                                getSingleDataDrug.deskripsi,
                                style: AppFonts().normalBlackFont,
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(
                          DrugDetailPage(drugName: getSingleDataDrug.namaObat),
                        );
                      },
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
