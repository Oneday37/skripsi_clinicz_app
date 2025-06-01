import 'package:flutter/material.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';

class DetailArticle extends StatefulWidget {
  const DetailArticle({super.key});

  @override
  State<DetailArticle> createState() => _DetailArticleState();
}

class _DetailArticleState extends State<DetailArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
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
