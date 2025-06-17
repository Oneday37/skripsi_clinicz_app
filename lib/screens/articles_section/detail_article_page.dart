import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';

class DetailArticlePage extends StatefulWidget {
  const DetailArticlePage({super.key});

  @override
  State<DetailArticlePage> createState() => _DetailArticlePageState();
}

class _DetailArticlePageState extends State<DetailArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: AppColors.bgColor,
        title: Text("Article", style: AppFonts().titleFont),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                Image.asset(
                  "assets/article_dummy_picture.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: double.infinity),
                      child: Stack(
                        children: [
                          Text(
                            AppDummyText().dummyArticleTitle,
                            style: TextStyle(
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 5
                                    ..color = Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            AppDummyText().dummyArticleTitle,
                            style: TextStyle(color: AppColors.bgColor),
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
            padding: const EdgeInsets.all(20),
            child: Text(
              AppDummyText().dummyArticle,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
