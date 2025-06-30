import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drug_detail_shop_page.dart';
import 'package:skripsi_clinicz_app/services/history_services.dart';

class DetailDrugRecommendationPage extends StatelessWidget {
  final String getDataID, diseaseName;
  const DetailDrugRecommendationPage({
    super.key,
    required this.getDataID,
    required this.diseaseName,
  });

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
          "Pengobatan $diseaseName",
          style: AppFonts().normalGreetingFontInside,
        ),
        centerTitle: true,
      ),

      // CONTAINER OF PREDICTION RESULT
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: HistoryServices().getDetailDrugRecommendationHistory(
            getDataID,
          ),
          builder: (context, snapshot) {
            print(getDataID);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      "assets/lottie_search_data_loading.json",
                    ),
                    Text("Sedang memuat data...", style: AppFonts().titleFont),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Text("Terjadi kesalahan: ${snapshot.hasError}"),
              );
            } else if (diseaseName == "Hepatitis") {
              return Center(
                child: Text(
                  "Pengobatan Hepatits bergantung pada jenis hepatitis yang diderita Harap konsultasikan ke dokter terlebih dahulu.",
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
                itemCount: getData!.output.length,
                itemBuilder: (context, index) {
                  final getSingleDataDrug = getData.output[index];
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
                                getSingleDataDrug.obat,
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
                          DrugDetailPage(drugName: getSingleDataDrug.obat),
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
