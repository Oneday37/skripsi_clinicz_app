import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:iconify_flutter_plus/icons/bx.dart';
import 'package:iconify_flutter_plus/icons/el.dart';
import 'package:iconify_flutter_plus/icons/ep.dart';
import 'package:iconify_flutter_plus/icons/fa.dart';
import 'package:iconify_flutter_plus/icons/fa6_solid.dart';
import 'package:iconify_flutter_plus/icons/gis.dart';
import 'package:iconify_flutter_plus/icons/grommet_icons.dart';
import 'package:iconify_flutter_plus/icons/la.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/medical_icon.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/data/drug_data.dart';
import 'package:skripsi_clinicz_app/models/drug_model.dart';
import 'package:skripsi_clinicz_app/screens/articles_section/articles_page.dart';
import 'package:skripsi_clinicz_app/screens/prediction_section/prediction_disease_page.dart';
import 'package:skripsi_clinicz_app/widgets/custom_main_features_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/clinicz_logo_2.png"),
        title: Row(
          children: [
            Text(
              "DiagnoCare",
              style: GoogleFonts.roboto(color: AppColors.primaryColor),
            ),
            SizedBox(width: 30),

            // SEARCH BAR FOR ARTICLE
            Expanded(
              child: Text(
                "Muhammad Ridho",
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
            Icon(Icons.account_circle, color: AppColors.primaryColor, size: 30),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // WELCOMING SECTION
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                text: "Hello ",
                style: GoogleFonts.oswald(
                  color: AppColors.primaryColor,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "Tn. Muhammad Ridho",
                    style: GoogleFonts.oswald(
                      color: AppColors.primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Selamat Datang di DiagnoCare",
              style: GoogleFonts.oswald(
                color: AppColors.primaryColor,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 50),

            // MAIN FEATURE
            SizedBox(
              height: MediaQuery.of(context).size.width / 4,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // CONTAINER FOR DRUGS SHOP
                  CustomMainFeaturesIcon(
                    featureIcon: Iconify(Bi.shop),
                    featureName: "Toko Obat",
                    directPage: () {},
                  ),
                  SizedBox(width: 20),

                  // CONTAINER FOR DISEASE PREDICTION
                  CustomMainFeaturesIcon(
                    featureIcon: Iconify(MedicalIcon.i_medical_library),
                    featureName: "Prediksi Penyakit",
                    directPage: PredictionDiseasePage(),
                  ),
                  SizedBox(width: 20),

                  // CONTAINER FOR CHATBOT AI
                  CustomMainFeaturesIcon(
                    featureIcon: Image.asset("assets/chatbot.png"),
                    featureName: "Chatbot AI",
                    directPage: () {},
                  ),
                  SizedBox(width: 20),

                  // CONTAINER FOR NEARBY CLINIC
                  CustomMainFeaturesIcon(
                    featureIcon: Iconify(La.map_marked_alt),
                    featureName: "Klinik Sekitar",
                    directPage: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Produk Kesehatan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            // DRUG FEATURE
            SizedBox(
              height: MediaQuery.of(context).size.width / 3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: drugs.length,
                itemBuilder: (_, index) {
                  DrugModel getDataDrug = drugs[index];
                  return Padding(
                    padding:
                        index == 4
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      child: SizedBox(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width / 5.5,
                              width: MediaQuery.of(context).size.width / 5.5,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.asset(
                                getDataDrug.imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(getDataDrug.drugName),
                          ],
                        ),
                      ),
                      onTap: () {
                        print("Anda menekan ${getDataDrug.drugName}");
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),

            // ARTICLES AREA
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Baca Artikel Kami",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.fourthColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Text(
                        "Lihat Semua",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(ArticlesPage());
                  },
                ),
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
