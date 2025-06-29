import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/services/history_services.dart';

class DetailDiseasePredictionPage extends StatelessWidget {
  final String getDataID, diseaseName;
  const DetailDiseasePredictionPage({
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
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(diseaseName, style: AppFonts().normalGreetingFontInside),
        centerTitle: true,
      ),

      // CONTAINER OF PREDICTION RESULT
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: HistoryServices().getDetailDiseasePredictionHistory(
            getDataID,
          ),
          builder: (context, snapshot) {
            print(getDataID);

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.network(
                    "https://lottie.host/773ae2e1-0078-4f47-bc1b-fcf247e8224a/Xm3svCgTAm.json",
                  ),
                  Text("Sedang memuat data...", style: AppFonts().titleFont),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              final getDiseaseHistory = snapshot.data;
              return ListView(
                children: [
                  Container(
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
                          Text("Deskripsi", style: AppFonts().subTitleFont),
                          SizedBox(height: 10),

                          // DESCRIPTION OF DISEASE
                          Text(
                            getDiseaseHistory!.output.first.deskripsi,
                            style: AppFonts().normalBlackFont,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 30),

                          Text("Penyebab", style: AppFonts().subTitleFont),
                          SizedBox(height: 10),

                          // CAUSE OF DISEASE
                          Text(
                            getDiseaseHistory.output.first.penyebab,
                            style: AppFonts().normalBlackFont,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 30),

                          Text("Pencegahan", style: AppFonts().subTitleFont),
                          SizedBox(height: 10),

                          // PREVENTION OF DISEASE
                          Text(
                            getDiseaseHistory.output.first.pencegahan,
                            style: AppFonts().normalBlackFont,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 40),

                          // ALERT MESSAGE !!!
                          RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              text: "Note: ",
                              style: AppFonts().normalBlackBoldFont,
                              children: [
                                TextSpan(
                                  text:
                                      "Untuk pemeriksaan lebih lanjut, diharapkan untuk menghubungi dokter",
                                  style: AppFonts().normalBlackFont,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),

                          // SOURCE OF DATA
                          RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              text: "Sumber: ",
                              style: AppFonts().normalBlackBoldFont,
                              children: [
                                TextSpan(
                                  text: getDiseaseHistory.output.first.sumber,
                                  style: AppFonts().normalBlackFont,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
