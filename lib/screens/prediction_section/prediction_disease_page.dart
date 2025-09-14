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
  final TextEditingController gejalaController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  List selectedAreas = [];

  final List<String> listAreaPenyakit = [
    "Dada",
    "Gigi",
    "Hidung",
    "Kaki",
    "Kelopak Mata",
    "Kepala",
    "Kuku",
    "Kulit",
    "Leher",
    "Lengan",
    "Mata",
    "Mulut",
    "Otot",
    "Pencernaan",
    "Perut",
    "Rambut",
    "Saraf",
    "Sendi",
    "Telinga",
    "Tenggorokan",
    "Umum",
    "Wajah",
  ];

  // METHOD FOR PREDICTION HANDLER
  void predictionHandler() async {
    final symptomsMessage = gejalaController.text.trim();

    if (symptomsMessage.isEmpty) {
      Get.snackbar(
        "Peringatan",
        "Harap Memasukkan Gejala",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedAreas.isEmpty) {
      Get.snackbar(
        "Peringatan",
        "Harap Memilih Area Panyekit (Minimal 1)",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => isLoading = true);

    final prediction = await AIServices().getPrediction(
      selectedAreas,
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
                    style: AppFonts().normalRedFont,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),

                  // CONTAINER FOR DISEASE AREA (MULTI SELECT)
                  Text(
                    "Pilih Area Penyakit",
                    style: AppFonts().normalBlackBoldFont,
                  ),

                  const SizedBox(height: 10),

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
                    child: DropdownButtonFormField<String>(
                      menuMaxHeight: 300,
                      value: null,
                      decoration: InputDecoration(
                        hintText: "Pilih area penyakit",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                      ),
                      items:
                          listAreaPenyakit.map((area) {
                            return DropdownMenuItem<String>(
                              value: area,
                              child: Text(area),
                            );
                          }).toList(),
                      selectedItemBuilder: (context) {
                        // Selalu tampilkan placeholder meskipun ada pilihan
                        return listAreaPenyakit.map((_) {
                          return const Text(
                            "Pilih area penyakit",
                            style: TextStyle(color: Colors.grey),
                          );
                        }).toList();
                      },
                      onChanged: (value) {
                        if (value != null && !selectedAreas.contains(value)) {
                          setState(() {
                            selectedAreas.add(value);
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8.0,
                    children:
                        selectedAreas.map((area) {
                          return Chip(
                            label: Text(area),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () {
                              setState(() {
                                selectedAreas.remove(area);
                              });
                            },
                          );
                        }).toList(),
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
                        hint: RichText(
                          text: TextSpan(
                            text:
                                "Masukkan gejala yang dirasakan (Minimal 5 gejala yang dipisahkan dengan tanda koma)\n\n",
                            style: AppFonts().inputFieldFont,
                            children: [
                              TextSpan(
                                text:
                                    "(Contoh: Sakit, Nyeri, Kaku, Berdenyut dengan intensitas sedang, Sensitif cahaya, Sensitif suara)",
                                style: AppFonts().normalRedFont,
                              ),
                            ],
                          ),
                        ),
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
                          print(selectedAreas);
                          print(gejalaController.text);
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
