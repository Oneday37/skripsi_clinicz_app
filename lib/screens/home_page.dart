import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:iconify_flutter_plus/icons/la.dart';
import 'package:iconify_flutter_plus/icons/medical_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/data/disease_by_category_data.dart';
import 'package:skripsi_clinicz_app/screens/chatbot_page.dart';
import 'package:skripsi_clinicz_app/screens/disease_section/disease_by_category_page.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drugs_shop_page.dart';
import 'package:skripsi_clinicz_app/screens/articles_section/articles_page.dart';
import 'package:skripsi_clinicz_app/screens/articles_section/detail_article_page.dart';
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
                leading: Image.asset(
                  color: AppColors.primaryColor,
                  "assets/diagnocare_logo2.png",
                  fit: BoxFit.cover,
                ),

                // leadingWidth: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "DiagnoCare",
                      style: AppFonts().normalGreetingFontInside,
                    ),
                    SizedBox(width: 30),

                    // AREA FOR ACCOUNT
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              getDataProfile.usernamePengguna,
                              style: AppFonts().normalGreetingFontInside,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 20),
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
                                getDataProfile.profileImagePengguna,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    "https://pbs.twimg.com/profile_images/1321030814436655106/87OcbZNm_400x400.jpg",
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
                        text: "Halo ",
                        style: AppFonts().greetingFontInside,
                        children: [
                          TextSpan(
                            text: getDataProfile.usernamePengguna,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CONTAINER FOR DISEASE PREDICTION
                        CustomMainFeaturesIcon(
                          featureIcon: Iconify(
                            MedicalIcon.i_medical_library,
                            color: Colors.white,
                          ),
                          featureName: "Prediksi\nPenyakit",
                          directPage: PredictionDiseasePage(),
                        ),

                        // CONTAINER FOR DRUGS SHOP
                        CustomMainFeaturesIcon(
                          featureIcon: Iconify(Bi.shop, color: Colors.white),
                          featureName: "Toko Obat",
                          directPage: DrugShopPage(),
                        ),

                        // CONTAINER FOR CHATBOT AI
                        CustomMainFeaturesIcon(
                          featureIcon: Image.asset(
                            "assets/chatbot.png",
                            color: Colors.white,
                          ),
                          featureName: "DiagnoCare Bot",
                          directPage: ChatBotPage(
                            profileImage: getDataProfile.profileImagePengguna,
                          ),
                        ),

                        // CONTAINER FOR NEARBY CLINIC
                        CustomMainFeaturesIcon(
                          featureIcon: Iconify(
                            La.map_marked_alt,
                            color: Colors.white,
                          ),
                          featureName: "Faskes Sekitar",
                          directPage: NearbyFaskesPage(),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),
                    Text(
                      "Kenali Berbagai Penyakit Yuk!",
                      style: AppFonts().subTitleFont,
                    ),
                    SizedBox(height: 10),

                    // DISEASE FEATURE
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 3,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: diseaseCategory.length,
                        itemBuilder: (_, index) {
                          final getDataDisease = diseaseCategory[index];
                          return GestureDetector(
                            child: Padding(
                              padding:
                                  getDataDisease.diseaseCategory ==
                                          "Penyakit Perut"
                                      ? EdgeInsets.zero
                                      : EdgeInsets.only(right: 35),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.width / 6,
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 5,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child:
                                          getDataDisease.diseaseCategory ==
                                                  "Penyakit Telinga"
                                              ? SvgPicture.asset(
                                                "assets/ear.svg",
                                                color: Colors.white,
                                              )
                                              : Iconify(
                                                "${getDataDisease.icon}",
                                                color: Colors.white,
                                              ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    getDataDisease.displayDiseaseName,
                                    style: AppFonts().normalBlackFont,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Get.to(
                                DiseaseByCategoryPage(
                                  diseaseCategory:
                                      getDataDisease.diseaseCategory,
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
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              child: Text(
                                "Lihat Semua",
                                style: AppFonts().normalWhiteBoldFont,
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
                              LottieBuilder.asset(
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
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // ARTICLE THUMBNAIL
                                        SizedBox(
                                          height: 250,
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            child: Image.network(
                                              getSingleArticle.imageArticle,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                        // ARTICLE TITLE
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: Text(
                                            getSingleArticle.titleArticle,
                                            style: AppFonts().subTitleFont,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 15,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width /
                                                    2,
                                                child: Wrap(
                                                  spacing: 8,
                                                  runSpacing: 8,
                                                  children:
                                                      getSingleArticle.tagArticle.map((
                                                        tag,
                                                      ) {
                                                        return ConstrainedBox(
                                                          constraints:
                                                              BoxConstraints(
                                                                maxWidth:
                                                                    MediaQuery.of(
                                                                      context,
                                                                    ).size.width /
                                                                    2,
                                                              ),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                color:
                                                                    Colors
                                                                        .black,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    12,
                                                                  ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                        0.3,
                                                                      ),
                                                                  blurRadius: 5,
                                                                  offset:
                                                                      const Offset(
                                                                        0,
                                                                        5,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 8,
                                                                ),
                                                            child: Text(
                                                              "#$tag",
                                                              style:
                                                                  AppFonts()
                                                                      .normalBlackTagFont,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomButtonInside(
                                                  label: "Baca Artikel",
                                                  onTap: () {
                                                    Get.to(
                                                      DetailArticlePage(
                                                        articleId:
                                                            getSingleArticle
                                                                .idArticle,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Get.to(
                                    DetailArticlePage(
                                      articleId: getSingleArticle.idArticle,
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
