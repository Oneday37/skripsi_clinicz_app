import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:iconify_flutter_plus/icons/la.dart';
import 'package:iconify_flutter_plus/icons/medical_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/data/drug_data.dart';
import 'package:skripsi_clinicz_app/screens/chatbot_page.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drugs_shop_page.dart';
import 'package:skripsi_clinicz_app/models/drug_model.dart';
import 'package:skripsi_clinicz_app/screens/articles_section/articles_page.dart';
import 'package:skripsi_clinicz_app/screens/articles_section/detail_article_page.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drugs_by_category_page.dart';
import 'package:skripsi_clinicz_app/screens/nearby_faskes_page.dart';
import 'package:skripsi_clinicz_app/screens/prediction_section/prediction_disease_page.dart';
import 'package:skripsi_clinicz_app/services/authentication_services.dart';
import 'package:skripsi_clinicz_app/services/online_articles_services.dart';
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
    return FutureBuilder(
      future: AuthenticationServices().getProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset("assets/lottie_loading_animation.json"),
              Text("Sedang memuat data...", style: AppFonts().titleFont),
            ],
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Gagal memuat data', style: AppFonts().titleFont)],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          final getDataProfile = snapshot.data!;
          return ListView(
            children: [
              AppBar(
                backgroundColor: AppColors.bgColor,
                leading: Image.asset("assets/clinicz_logo_2.png"),
                title: Row(
                  children: [
                    Text(
                      "DiagnoCare",
                      style: AppFonts().normalGreetingFontInside,
                    ),
                    SizedBox(width: 30),

                    // AREA FOR ACCOUNT
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              getDataProfile.username,
                              style: AppFonts().normalBlackFont,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(130),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Image.network(
                                getDataProfile.profileImage,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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
                            text: getDataProfile.username,
                            style: AppFonts().normalGreetingFontInside,
                          ),
                        ],
                      ),
                      maxLines: 2,
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
                          directPage: ChatBotPage(),
                        ),
                        SizedBox(width: 20),

                        // CONTAINER FOR NEARBY CLINIC
                        CustomMainFeaturesIcon(
                          featureIcon: Iconify(La.map_marked_alt),
                          featureName: "Faskes Sekitar",
                          directPage: NearbyFaskesPage(),
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
                                    height:
                                        MediaQuery.of(context).size.width / 6,
                                    width:
                                        MediaQuery.of(context).size.width / 6,
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
                                    getDataDrug.displayDrugName,
                                    style: AppFonts().normalBlackFont,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Get.to(
                                DrugsByCategoryPage(
                                  displayDrugName: getDataDrug.displayDrugName,
                                  drugCategory: getDataDrug.drugCategory,
                                ),
                              );
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
                        Text(
                          "Baca Artikel Kami",
                          style: AppFonts().subTitleFont,
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.thirdColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              child: Text(
                                "Lihat Semua",
                                style: AppFonts().normalBlackBoldFont,
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

                    // CONTAINER FOR LIST ARTICLES
                    FutureBuilder(
                      future: OnlineArticlesServices().getAllArticles(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                height: MediaQuery.of(context).size.width / 2,
                                width: MediaQuery.of(context).size.width / 2,
                                "assets/lottie_search_data_loading.json",
                              ),
                              Text(
                                "Sedang memuat artikel...",
                                style: AppFonts().titleFont,
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        } else {
                          final getAllDataArticles = snapshot.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: getAllDataArticles!.length,
                            itemBuilder: (_, index) {
                              final getSingleArticle =
                                  getAllDataArticles[index];
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // ARTICLE THUMBNAIL
                                          SizedBox(
                                            height: 250,
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                getSingleArticle.img,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),

                                          // ARTICLE TITLE
                                          Text(
                                            getSingleArticle.title,
                                            style: AppFonts().subTitleFont,
                                            textAlign: TextAlign.justify,
                                          ),
                                          SizedBox(height: 30),
                                          CustomButtonInside(
                                            label: "Baca Artikel",
                                            onTap: () {
                                              Get.to(
                                                DetailArticlePage(
                                                  articleId:
                                                      getSingleArticle.id,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Get.to(
                                    DetailArticlePage(
                                      articleId: getSingleArticle.id,
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
