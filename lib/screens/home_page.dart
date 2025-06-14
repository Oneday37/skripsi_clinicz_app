import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:iconify_flutter_plus/icons/la.dart';
import 'package:iconify_flutter_plus/icons/medical_icon.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/data/drug_data.dart';
import 'package:skripsi_clinicz_app/drug_section/drug_shop_page.dart';
import 'package:skripsi_clinicz_app/models/drug_model.dart';
import 'package:skripsi_clinicz_app/screens/articles_section/articles_page.dart';
import 'package:skripsi_clinicz_app/screens/articles_section/detail_article_page.dart';
import 'package:skripsi_clinicz_app/screens/prediction_section/prediction_disease_page.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';
import 'package:skripsi_clinicz_app/widgets/custom_main_features_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppBar(
          backgroundColor: AppColors.bgColor,
          leading: Image.asset("assets/clinicz_logo_2.png"),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("DiagnoCare", style: AppFonts().normalGreetingFontInside),
              SizedBox(width: 30),

              // AREA FOR ACCOUNT
              Row(
                children: [
                  Text("Muhammad Ridho", style: AppFonts().normalBlackFont),
                  SizedBox(width: 10),
                  Icon(
                    Icons.account_circle,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              // WELCOMING SECTION
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: "Hello ",
                  style: AppFonts().greetingFontInside,
                  children: [
                    TextSpan(
                      text: "Tn. Muhammad Ridho",
                      style: AppFonts().normalGreetingFontInside,
                    ),
                  ],
                ),
              ),
              Text(
                "Selamat Datang di DiagnoCare",
                style: AppFonts().normalGreetingFontInside,
              ),
              SizedBox(height: 40),

              // MAIN FEATURE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // CONTAINER FOR DRUGS SHOP
                  CustomMainFeaturesIcon(
                    featureIcon: Iconify(Bi.shop),
                    featureName: "Toko Obat",
                    directPage: DrugShopPage(),
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

              SizedBox(height: 30),
              Text("Produk Kesehatan", style: AppFonts().subTitleFont),
              SizedBox(height: 10),

              // DRUG FEATURE
              SizedBox(
                height: MediaQuery.of(context).size.width / 4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: drugs.length,
                  itemBuilder: (_, index) {
                    DrugModel getDataDrug = drugs[index];
                    return GestureDetector(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width / 6,
                              width: MediaQuery.of(context).size.width / 6,
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
                            Text(
                              getDataDrug.drugName,
                              style: AppFonts().normalBlackFont,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        print("Anda menekan ${getDataDrug.drugName}");
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 30),

              // ARTICLES AREA
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Baca Artikel Kami", style: AppFonts().subTitleFont),
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
              SizedBox(height: 10),

              // CONTAINER FOR LIST ARTICLES
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.thirdColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              // ARTICLE THUMBNAIL
                              SizedBox(
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "assets/article_dummy_picture.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),

                              // ARTICLE TITLE
                              Text(
                                AppDummyText().dummyArticleTitle,
                                style: AppFonts().normalBlackFont,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              CustomButtonInside(
                                label: "Baca Artikel",
                                onTap: () {
                                  Get.to(DetailArticlePage());
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.to(DetailArticlePage());
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
