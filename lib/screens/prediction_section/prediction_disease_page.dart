import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/prediction_section/prediction_result_page.dart';
import 'package:skripsi_clinicz_app/services/ai_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class PredictionDiseasePage extends StatefulWidget {
  const PredictionDiseasePage({super.key});

  @override
  State<PredictionDiseasePage> createState() => _PredictionDiseasePageState();
}

class _PredictionDiseasePageState extends State<PredictionDiseasePage> {
  final TextEditingController areaPenyakitController = TextEditingController();
  final TextEditingController gejalaController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final List<String> listAreaPenyakit = [
    "Tenggorokan",
    "Hidung",
    "Dada",
    "Kepala",
    "Perut",
    "Leher",
    "Wajah",
    "Punggung",
  ];

  void predictionHandler() async {
    final areaDisease = areaPenyakitController.text.trim();
    final symptomsMessage = gejalaController.text.trim();
    if (symptomsMessage.isEmpty) {
      Get.snackbar(
        "Peringatan",
        "Harap memasukkan gejala",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => isLoading = true);

    final prediction = await AIServices().getPrediction(
      areaDisease,
      symptomsMessage,
    );

    setState(() => isLoading = false);

    if (prediction != null && mounted) {
      Get.to(PredictionResultPage(prediction: prediction));
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Prediksi Penyakit",
          style: AppFonts().normalGreetingFontInside,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // APPLICATION LOGO
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      "assets/diagnocare_logo2.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Prediksi Penyakitmu Sekarang !",
                      style: AppFonts().normalGreetingFontInside,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // INSTRUCTIONS
                  Text(
                    "Tuliskan gejala yang dirasakan pada tubuh anda secara spesifik",
                    style: AppFonts().normalBlackFont,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "(Contoh: Telinga nyeri, mata merah, hidung tersumbat)",
                    style: AppFonts().normalBlackBoldFont,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),

                  // CONTAINER FOR ENTERING DISEASE AREA
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
                    child: TypeAheadField<String>(
                      controller: areaPenyakitController,
                      hideOnEmpty: true,
                      suggestionsCallback: (pattern) async {
                        if (pattern.isEmpty) {
                          return [];
                        }

                        return listAreaPenyakit
                            .where(
                              (item) => item.toLowerCase().contains(
                                pattern.toLowerCase(),
                              ),
                            )
                            .toList();
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(title: Text(suggestion));
                      },
                      onSelected: (suggestion) {
                        List<String> parts = areaPenyakitController.text.split(
                          ',',
                        );
                        parts[parts.length - 1] = suggestion;

                        setState(() {
                          areaPenyakitController.text = parts
                              .map((e) => e.trim())
                              .where((e) => e.isNotEmpty)
                              .join(', ');
                          areaPenyakitController
                              .selection = TextSelection.fromPosition(
                            TextPosition(
                              offset: areaPenyakitController.text.length,
                            ),
                          );
                        });
                      },
                      builder: (context, controller, focusNode) {
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          cursorHeight: 20,
                          cursorColor:
                              Colors
                                  .blue, // ganti sesuai AppColors.primaryColor
                          textCapitalization: TextCapitalization.sentences,
                          textAlign: TextAlign.justify,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: "Area Penyakit (pisahkan dengan koma)",
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),

                  // CONTAINER FOR ENTERING SYMPTOMS OF DISEASE
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
                    child: TextFormField(
                      controller: gejalaController,
                      cursorHeight: 20,
                      cursorColor: AppColors.primaryColor,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      textAlign: TextAlign.justify,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "Masukkan gejala yang dirasakan",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Input tidak boleh kosong';
                        }
                        final listGejala =
                            value
                                .split(',')
                                .map((e) => e.trim())
                                .where((e) => e.isNotEmpty)
                                .toList();

                        if (listGejala.length < 5) {
                          return 'Masukkan minimal 5 gejala yang dipisahkan dengan koma';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 70),

                  // ANALYSIS BUTTON
                  isLoading
                      ? Center(
                        child: Column(
                          children: [
                            LottieBuilder.asset(
                              "assets/lottie_analysis_loading.json",
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Sedang menganalisis gejala ...",
                              style: AppFonts().normalBlackFont,
                            ),
                          ],
                        ),
                      )
                      : CustomButtonInside(
                        label: "Prediksi",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            predictionHandler();
                          }
                        },
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
