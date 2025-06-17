import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/history_prediction_section/detail_disease_prediction_page.dart';
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
        child: ListView(
          children: [
            Text("Riwayat Prediksi", style: AppFonts().subTitleFont),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomFieldSettings(
                    prefixIcon: Icon(Icons.sick),
                    label: "Penyakit ${index + 1}",
                    onTap: () {
                      Get.to(DetailDiseasePredictionPage());
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
