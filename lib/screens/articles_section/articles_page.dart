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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
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
                LottieBuilder.asset("assets/lottie_search_data_loading.json"),
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
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
                                            MediaQuery.of(context).size.width /
                                            2,
                                        child: Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children:
                                              getSingleArticle.tagArticle.map((
                                                tag,
                                              ) {
                                                return ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width /
                                                        2,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.3),
                                                          blurRadius: 5,
                                                          offset: const Offset(
                                                            0,
                                                            5,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 8,
                                                        ),
                                                    child: Text(
                                                      "#$tag",
                                                      style:
                                                          AppFonts()
                                                              .normalBlackTagFont,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                    getSingleArticle.idArticle,
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
