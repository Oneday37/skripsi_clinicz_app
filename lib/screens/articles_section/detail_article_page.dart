import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/services/online_articles_services.dart';

class DetailArticlePage extends StatefulWidget {
  String articleId;
  DetailArticlePage({super.key, required this.articleId});

  @override
  State<DetailArticlePage> createState() => _DetailArticlePageState();
}

class _DetailArticlePageState extends State<DetailArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.thirdColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Article", style: AppFonts().titleFont),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: OnlineArticlesServices().getSingleArticle(widget.articleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final getDataArticle = snapshot.data;
            return ListView(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    children: [
                      Image.network(
                        getDataArticle!.img,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: double.infinity,
                            ),
                            child: Stack(
                              children: [
                                Text(
                                  getDataArticle.title,
                                  style: AppFonts().strokeArticleTitleFont,
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  getDataArticle.title,
                                  style: AppFonts().baseArticleTitleFont,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Html(
                    data: getDataArticle.content,
                    style: {
                      'p': Style(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.justify,
                      ),
                      'b': Style(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.justify,
                      ),
                      'h3': Style(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.justify,
                      ),
                      'h4': Style(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.justify,
                      ),
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
