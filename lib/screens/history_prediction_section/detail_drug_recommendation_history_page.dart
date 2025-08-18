import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/data/disease_exception_output_data.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drug_recommendation_detail_page.dart';
import 'package:skripsi_clinicz_app/screens/nearby_faskes_page.dart';
import 'package:skripsi_clinicz_app/services/history_services.dart';
import 'package:skripsi_clinicz_app/services/online_shop_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';

class DetailDrugRecommendationPage extends StatefulWidget {
  final String getDataID, diseaseName;
  const DetailDrugRecommendationPage({
    super.key,
    required this.getDataID,
    required this.diseaseName,
  });

  @override
  State<DetailDrugRecommendationPage> createState() =>
      _DetailDrugRecommendationPageState();
}

class _DetailDrugRecommendationPageState
    extends State<DetailDrugRecommendationPage> {
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
          "Pengobatan ${widget.diseaseName}",
          style: AppFonts().titleFont,
        ),
        centerTitle: true,
      ),
      // CONTAINER OF PREDICTION RESULT
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: HistoryServices().getDetailDrugRecommendationHistory(
            widget.getDataID,
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
                    Text("Sedang memuat data...", style: AppFonts().titleFont),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Terjadi kesalahan: ${snapshot.hasError}"),
              );
            } else if (diseaseExceptionOutput.contains(widget.diseaseName)) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pengobatan ${widget.diseaseName} dianjurkan untuk berkonsultasi ke dokter terlebih dahulu",
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
              final getData = snapshot.data;
              return ListView.builder(
                itemCount: getData!.output.length,
                itemBuilder: (context, index) {
                  final getSingleDataDrug = getData.output[index];
                  return FutureBuilder(
                    future: OnlineShopServices().getSingleDrusShop(
                      getSingleDataDrug.namaObat,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else {
                        final getSingleDataDrug2 = snapshot.data;
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
                                          getSingleDataDrug.namaObat,
                                          style: AppFonts().subTitleFont,
                                        ),
                                        const SizedBox(height: 20),

                                        // DESCRIPTION
                                        Text(
                                          getSingleDataDrug.deskripsiObat,
                                          style: AppFonts().normalBlackFont,
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),

                                  Container(),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
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
                                            getSingleDataDrug2!.gambarObat,
                                            // fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // DETAIL BUTTON
                                        GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
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
                                                    getSingleDataDrug.namaObat,
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
                      }
                    },
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
