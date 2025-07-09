import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/services/disease_service.dart';

class DetailDiseaseByCategoryPage extends StatelessWidget {
  final String diseaseName;
  const DetailDiseaseByCategoryPage({super.key, required this.diseaseName});

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
        title: Text(diseaseName, style: AppFonts().titleFont),
        centerTitle: true,
      ),

      // CONTAINER OF PREDICTION RESULT
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          future: DiseaseService().getSingleDiseaseDetail(diseaseName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset("assets/lottie_search_data_loading.json"),
                  Text("Sedang memuat data...", style: AppFonts().titleFont),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              final getDataDisease = snapshot.data;
              return ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 7,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // DESCRIPTION OF DISEASE
                            Text("Deskripsi", style: AppFonts().subTitleFont),
                            SizedBox(height: 10),

                            // DESCRIPTION OF DISEASE
                            Text(
                              getDataDisease!.deskripsi,
                              style: AppFonts().normalBlackFont,
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 30),

                            Text("Penyebab", style: AppFonts().subTitleFont),
                            SizedBox(height: 10),

                            // CAUSE OF DISEASE
                            Text(
                              getDataDisease.penyebab,
                              style: AppFonts().normalBlackFont,
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 30),

                            Text("Pencegahan", style: AppFonts().subTitleFont),
                            SizedBox(height: 10),

                            // PREVENTION OF DISEASE
                            Text(
                              getDataDisease.pencegahan,
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
                                    text: getDataDisease.sumber,
                                    style: AppFonts().normalBlackFont,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(height: MediaQuery.of(context).size.width / 20),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
