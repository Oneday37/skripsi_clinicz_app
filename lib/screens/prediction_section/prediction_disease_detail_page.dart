import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drug_recommendation_page.dart';
import 'package:skripsi_clinicz_app/services/ai_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';

class PredictionDiseaseDetailPage extends StatefulWidget {
  final String diseaseName;
  const PredictionDiseaseDetailPage({super.key, required this.diseaseName});

  @override
  State<PredictionDiseaseDetailPage> createState() =>
      _PredictionDiseaseDetailPageState();
}

class _PredictionDiseaseDetailPageState
    extends State<PredictionDiseaseDetailPage> {
  bool isLoading = false;

  void drugRecommendationSHandler(String diseaseNameForDrug) async {
    if (mounted) {
      Get.to(DrugRecommendationPage(diseaseNameForDrug: diseaseNameForDrug));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal mendapatkan hasil prediksi.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: Text(widget.diseaseName, style: AppFonts().titleFont),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: AIServices().getDetailPrediction(widget.diseaseName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset("assets/lottie_search_data_loading.json"),
                  SizedBox(height: 20),
                  Text("Sedang memuat data ...", style: AppFonts().titleFont),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              final getDetailDataPrediction = snapshot.data;
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
                              getDetailDataPrediction!.deskripsiPenyakit,
                              style: AppFonts().normalBlackFont,
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 30),

                            Text("Pengobatan", style: AppFonts().subTitleFont),
                            SizedBox(height: 10),

                            // CAUSE OF DISEASE
                            Text(
                              getDetailDataPrediction.pengobatanPenyakit,
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
                                    text:
                                        getDetailDataPrediction.sumberInformasi,
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

                  SizedBox(height: 50),

                  // BUTTON FOR GET MAIN TREATMENT
                  isLoading
                      ? Center(
                        child: Column(
                          children: [
                            LottieBuilder.asset(
                              "assets/lottie_search_data_loading.json",
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Harap menunggu ...",
                              style: AppFonts().normalBlackFont,
                            ),
                          ],
                        ),
                      )
                      : CustomButtonInside(
                        label: "Dapatkan Pengobatan",
                        onTap: () {
                          drugRecommendationSHandler(
                            getDetailDataPrediction.namaPenyakit,
                          );
                        },
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
