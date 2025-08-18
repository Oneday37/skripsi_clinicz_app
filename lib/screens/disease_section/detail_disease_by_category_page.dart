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
import 'package:skripsi_clinicz_app/services/disease_service.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';

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
                              getDataDisease!.deskripsiPenyakit,
                              style: AppFonts().normalBlackFont,
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 30),

                            Text("Penyebab", style: AppFonts().subTitleFont),
                            SizedBox(height: 10),

                            // CAUSE OF DISEASE
                            Text(
                              getDataDisease.penyebabPenyakit,
                              style: AppFonts().normalBlackFont,
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 30),

                            Text("Pencegahan", style: AppFonts().subTitleFont),
                            SizedBox(height: 10),

                            // PREVENTION OF DISEASE
                            Text(
                              getDataDisease.pencegahanPenyakit,
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
                                    text: getDataDisease.sumberInformasi,
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
                  Text("Rekomendasi Obat", style: AppFonts().subTitleFont),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 2,
                    child: FutureBuilder(
                      future: AIServices().getDrugRecommendations(
                        getDataDisease.namaPenyakit,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LottieBuilder.asset(
                                  "assets/lottie_search_data_loading.json",
                                ),
                                Text(
                                  "Harap Menunggu...",
                                  style: AppFonts().titleFont,
                                ),
                                Text(
                                  "Permintaan Anda Sedang diproses",
                                  style: AppFonts().titleFont,
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Terjadi kesalahan: ${snapshot.hasError}",
                            ),
                          );
                        } else if (diseaseExceptionOutput.contains(
                          getDataDisease.namaPenyakit,
                        )) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Pengobatan ${getDataDisease.namaPenyakit} dianjurkan untuk berkonsultasi ke dokter terlebih dahulu",
                                style: GoogleFonts.oswald(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 30),
                              CustomButtonInside(
                                label: "Deteksi Faskes Terdekat",
                                onTap: () => Get.to(NearbyFaskesPage()),
                              ),
                            ],
                          );
                        } else {
                          final getDrugData = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              final getSingleDrugData = getDrugData[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20,
                                  right: 20,
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.width / 3,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // NAME OF DRUG
                                              Text(
                                                getSingleDrugData.namaObat,
                                                style: AppFonts().subTitleFont,
                                              ),
                                              const SizedBox(height: 20),

                                              // DESCRIPTION OF DRUG
                                              Expanded(
                                                child: Text(
                                                  getSingleDrugData
                                                      .deskripsiObat,
                                                  style:
                                                      AppFonts()
                                                          .normalBlackFont,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.justify,
                                                ),
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
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  height:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width /
                                                      4,
                                                  width:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width /
                                                      4,
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
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        blurRadius: 5,
                                                        offset: const Offset(
                                                          0,
                                                          5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20,
                                                      ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Icon(
                                                        Icons.info_outline,
                                                        color: Colors.white,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        "Detail",
                                                        style:
                                                            AppFonts()
                                                                .normalWhiteBoldFont,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  Get.to(
                                                    DrugRecommendationDetailPage(
                                                      drugName:
                                                          getSingleDrugData
                                                              .namaObat,
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
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
