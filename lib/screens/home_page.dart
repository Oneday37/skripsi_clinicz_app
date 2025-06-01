import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/screens/detail_article.dart';

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

          // APPLICATION LOGO
          leading: Image.asset("assets/clinicz_logo_2.png"),
          title: Row(
            children: [
              Text(
                "Clinicz",
                style: GoogleFonts.roboto(color: AppColors.primaryColor),
              ),
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
                  padding:
                      index == 4
                          ? const EdgeInsets.all(0)
                          : const EdgeInsets.only(bottom: 20),
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
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Get.to(DetailArticle());
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
