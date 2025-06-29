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
                  LottieBuilder.network(
                    "https://lottie.host/773ae2e1-0078-4f47-bc1b-fcf247e8224a/Xm3svCgTAm.json",
                  ),
                  Text("Sedang memuat data...", style: AppFonts().titleFont),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: Text(
                  "Anda belum melakukan prediksi penyakit",
                  style: AppFonts().titleFont,
                ),
              );
            } else {
              final getDataPrediction = snapshot.data;
              return ListView.builder(
                itemCount: getDataPrediction!.length,
                itemBuilder: (context, index) {
                  final getSingleDataPrediction = getDataPrediction[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomFieldSettings(
                      prefixIcon: Icon(Icons.sick_outlined),
                      label: getSingleDataPrediction.nama,
                      onTap: () {
                        Get.to(
                          HistoryConclusionPage(
                            diseaseName: getSingleDataPrediction.nama,
                            index: index,
                          ),
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
