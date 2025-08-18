import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/services/ai_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_detail_drug.dart';

class DrugRecommendationDetailPage extends StatefulWidget {
  final String drugName;
  const DrugRecommendationDetailPage({super.key, required this.drugName});

  @override
  State<DrugRecommendationDetailPage> createState() =>
      _DrugRecommendationDetailPageState();
}

class _DrugRecommendationDetailPageState
    extends State<DrugRecommendationDetailPage> {
  String getLogoAssetFromStoreName(String storeName) {
    String fileName = storeName.toLowerCase().replaceAll(' ', '');
    return 'assets/${fileName}_logo.png';
  }

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

        // NAME OF DISEASE
        title: Text(widget.drugName, style: AppFonts().titleFont),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: AIServices().getDetailDrugRecommendations(widget.drugName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset("assets/lottie_search_data_loading.json"),
                Text("Sedang mengambil data...", style: AppFonts().titleFont),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final getSingleDataDrug = snapshot.data;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListView(
                children: [
                  Container(
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
                        children: [
                          // CONTAINER FOR IMAGE
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(getSingleDataDrug!.gambarObat),
                          ),
                          SizedBox(height: 30),

                          // DESCRIPTION OF TREATMENT
                          CustomDetailDrug(
                            label: "Deskripsi Obat:",
                            content: getSingleDataDrug.deskripsiObat,
                          ),
                          SizedBox(height: 30),

                          // MEDICINE INGREDIENTS
                          CustomDetailDrug(
                            label: "Kandungan:",
                            content: getSingleDataDrug.kandunganObat,
                          ),
                          SizedBox(height: 30),

                          // TREATMENT DOSAGE
                          CustomDetailDrug(
                            label: "Dosis Penggunaan:",
                            content: getSingleDataDrug.dosisObat,
                          ),
                          SizedBox(height: 30),

                          // TERMS OF USE
                          CustomDetailDrug(
                            label: "Aturan Pakai:",
                            content: getSingleDataDrug.dosisObat,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
