import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/prediction_section/prediction_result_page.dart';
import 'package:skripsi_clinicz_app/services/ai_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';

class PredictionDiseasePage extends StatefulWidget {
  const PredictionDiseasePage({super.key});

  @override
  State<PredictionDiseasePage> createState() => _PredictionDiseasePageState();
}

class _PredictionDiseasePageState extends State<PredictionDiseasePage> {
  TextEditingController gejalaController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void predictionHandler() async {
    final message = gejalaController.text.trim();
    if (message.isEmpty) {
      Get.snackbar(
        "Peringatan",
        "Harap memasukkan gejala",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    setState(() => isLoading = true);

    final prediction = await AIServices().getPrediction(message);

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
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
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
                SizedBox(height: 40),

                // DISEASE PREDICTION SECTION
                Text(
                  "Tuliskan gejala yang dirasakan pada tubuh anda secara spesifik",
                  style: AppFonts().normalBlackFont,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10),

                // DISEASE PREDICTION SECTION
                Text(
                  "(Contoh: Telinga nyeri, mata merah, hidung tersumbat)",
                  style: AppFonts().normalBlackBoldFont,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30),

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
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: gejalaController,
                      cursorHeight: 20,
                      cursorColor: AppColors.primaryColor,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      textAlign: TextAlign.justify,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Input tidak boleh kosong';
                        }
                        final gejalaList =
                            value
                                .split(',')
                                .map((e) => e.trim())
                                .where((e) => e.isNotEmpty)
                                .toList();

                        if (gejalaList.length < 5) {
                          return 'Masukkan minimal 5 gejala yang dipisahkan dengan koma';
                        }

                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 70),

                // ANALYSIS BUTTON FOR GET DISEASE FROM USER INPUT
                isLoading
                    ? Center(
                      child: Column(
                        children: [
                          LottieBuilder.asset(
                            "assets/lottie_analysis_loading.json",
                          ),
                          SizedBox(height: 10),
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
    );
  }
}
