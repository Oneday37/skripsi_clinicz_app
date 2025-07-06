import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/history_prediction_section/history_conclusion_page.dart';
import 'package:skripsi_clinicz_app/services/history_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_settings.dart';

class HistoryPredictionPage extends StatefulWidget {
  const HistoryPredictionPage({super.key});

  @override
  State<HistoryPredictionPage> createState() => _HistoryPredictionPageState();
}

class _HistoryPredictionPageState extends State<HistoryPredictionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        automaticallyImplyLeading: false,
        title: Text("Riwayat Prediksi Penyakit", style: AppFonts().titleFont),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: HistoryServices().getPredictionResult(),
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
              final getDataForDrug = snapshot.data;
              return FutureBuilder(
                future: HistoryServices().getHistoryPrediction(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.asset(
                          "assets/lottie_search_data_loading.json",
                        ),
                        Text(
                          "Sedang memuat data...",
                          style: AppFonts().titleFont,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else {
                    final getDataForDisease = snapshot.data;
                    if (getDataForDrug!.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset("assets/lottie_not_found.json"),
                          Text(
                            "Anda belum melakukan prediksi penyakit",
                            style: AppFonts().titleFont,
                          ),
                        ],
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: getDataForDrug.length,
                      itemBuilder: (context, index) {
                        final getSingleDataForDisease =
                            getDataForDisease![index];
                        final getSingleDataForDrug = getDataForDrug[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CustomFieldSettings(
                            prefixIcon: Icon(
                              Icons.sick_outlined,
                              color: Colors.white,
                            ),
                            label: getSingleDataForDrug.nama,
                            onTap: () {
                              Get.to(
                                HistoryConclusionPage(
                                  diseaseName: getSingleDataForDrug.nama,
                                  diseaseID: getSingleDataForDisease.id,
                                  drugID: getSingleDataForDrug.id,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
