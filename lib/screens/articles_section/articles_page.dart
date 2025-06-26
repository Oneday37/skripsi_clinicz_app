import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/articles_section/detail_article_page.dart';
import 'package:skripsi_clinicz_app/services/online_articles_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,

        // APPLICATION LOGO
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          children: [
            Text(
              "DiagnoCare Artikel",
              style: AppFonts().normalGreetingFontInside,
            ),
            SizedBox(width: 20),

            // SEARCH BAR FOR ARTICLE
            // Expanded(
            //   child: TextFormField(
            //     cursorColor: AppColors.primaryColor,
            //     cursorHeight: 25,
            //     decoration: InputDecoration(
            //       filled: true,
            //       fillColor: AppColors.thirdColor,
            //       prefixIcon: Icon(Icons.search, size: 25),
            //       prefixIconColor: AppColors.primaryColor,
            //       hintText: "Search article",
            //       hintStyle: TextStyle(color: AppColors.primaryColor),
            //       isDense: true,
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: AppColors.thirdColor),
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: AppColors.thirdColor),
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),

      body: FutureBuilder(
        future: OnlineArticlesServices().getAllArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.network(
                  "https://lottie.host/773ae2e1-0078-4f47-bc1b-fcf247e8224a/Xm3svCgTAm.json",
                ),
                SizedBox(height: 20),
                Text("Sedang mengambil data ...", style: AppFonts().titleFont),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final getAllDataArticles = snapshot.data;
            return ListView(
              children: [
                // LIST OF ARTICLES
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: getAllDataArticles!.length,
                    itemBuilder: (_, index) {
                      final getSingleArticle = getAllDataArticles[index];
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ARTICLE THUMBNAIL
                                  SizedBox(
                                    height: 250,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
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
                                  SizedBox(height: 20),
                                  CustomButtonInside(
                                    label: "Baca Artikel",
                                    onTap: () {
                                      Get.to(
                                        DetailArticlePage(
                                          articleId: getSingleArticle.id,
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
                            DetailArticlePage(articleId: getSingleArticle.id),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
