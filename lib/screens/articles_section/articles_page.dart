import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/articles_section/detail_article_page.dart';
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
            Text("DiagnoCare", style: AppFonts().normalGreetingFontInside),
            SizedBox(width: 20),

            // SEARCH BAR FOR ARTICLE
            Expanded(
              child: TextFormField(
                cursorColor: AppColors.primaryColor,
                cursorHeight: 25,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.thirdColor,
                  prefixIcon: Icon(Icons.search, size: 25),
                  prefixIconColor: AppColors.primaryColor,
                  hintText: "Search article",
                  hintStyle: TextStyle(color: AppColors.primaryColor),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.thirdColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.thirdColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: ListView(
        children: [
          // LIST OF ARTICLES
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              style: AppFonts().subTitleFont,
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
          ),
        ],
      ),
    );
  }
}
