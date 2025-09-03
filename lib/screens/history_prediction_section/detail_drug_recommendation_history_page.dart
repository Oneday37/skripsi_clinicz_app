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
import 'package:skripsi_clinicz_app/services/online_shop_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';

class DetailDrugRecommendationPage extends StatefulWidget {
  final String diseaseName;
  const DetailDrugRecommendationPage({super.key, required this.diseaseName});

  @override
  State<DetailDrugRecommendationPage> createState() =>
      _DetailDrugRecommendationPageState();
}

class _DetailDrugRecommendationPageState
    extends State<DetailDrugRecommendationPage> {
  final OnlineShopServices drugService = OnlineShopServices();
  Map<String, String?> drugImages = {};
  bool isLoadingImages = true;

  late Future<List<dynamic>> futureDrugList;

  @override
  void initState() {
    super.initState();
    futureDrugList = AIServices().getDrugRecommendations(widget.diseaseName);
    futureDrugList.then((drugs) async {
      Map<String, String?> tempImages = {};
      for (var drug in drugs) {
        final imageUrl = await drugService.getGambarByNama(drug.namaObat);
        tempImages[drug.namaObat] = imageUrl;
      }
      setState(() {
        drugImages = tempImages;
        isLoadingImages = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
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

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: futureDrugList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                isLoadingImages) {
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
                child: Text("Terjadi kesalahan: ${snapshot.error}"),
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
                  const SizedBox(height: 50),
                  CustomButtonInside(
                    label: "Deteksi Faskes Terdekat",
                    onTap: () => Get.to(NearbyFaskesPage()),
                  ),
                ],
              );
            } else {
              final getDrugData = snapshot.data;
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  final getSingleDrugData = getDrugData![index];
                  final imageUrl = drugImages[getSingleDrugData.namaObat];
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
                            // NAME & DESC OF DRUG
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getSingleDrugData.namaObat,
                                    style: AppFonts().subTitleFont,
                                  ),
                                  const SizedBox(height: 20),
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

                            const SizedBox(width: 15),

                            // PICTURE OF DRUG
                            Expanded(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child:
                                        imageUrl != null
                                            ? Image.network(
                                              imageUrl,
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
                                              fit: BoxFit.cover,
                                            )
                                            : Image.network(
                                              "https://kec-sipispis.serdangbedagaikab.go.id/administrator/assets/img/img_pelayanan/belumada2.jpg",
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
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                  const SizedBox(height: 10),

                                  // DETAIL BUTTON
                                  GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
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
                                        child: Center(
                                          child: Text(
                                            "Detail",
                                            style:
                                                AppFonts().normalWhiteBoldFont,
                                          ),
                                        ),
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
