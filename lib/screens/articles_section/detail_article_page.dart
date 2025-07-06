import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/services/online_articles_services.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailArticlePage extends StatefulWidget {
  final String articleId;
  const DetailArticlePage({super.key, required this.articleId});

  @override
  State<DetailArticlePage> createState() => _DetailArticlePageState();
}

class _DetailArticlePageState extends State<DetailArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: FutureBuilder(
        future: OnlineArticlesServices().getSingleArticle(widget.articleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset("assets/lottie_search_data_loading.json"),
                SizedBox(height: 20),
                Text("Sedang memuat artikel ...", style: AppFonts().titleFont),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final getDataArticle = snapshot.data;
            return ListView(
              children: [
                AppBar(
                  backgroundColor: AppColors.bgColor,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  title: Text("Article", style: AppFonts().titleFont),
                  centerTitle: true,
                ),

                // ARTICLE IMAGE
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    getDataArticle!.img,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getDataArticle.title,
                        style: AppFonts().subTitleFont,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10),
                      Text(
                        getDataArticle.date,
                        style: AppFonts().normalBlackFont,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Penulis: ${getDataArticle.doctor.name}",
                        style: AppFonts().normalBlackFont,
                      ),
                    ],
                  ),
                ),

                // ARTICLE CONTENT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Html(
                    data: getDataArticle.content,
                    onLinkTap: (url, attributes, element) async {
                      if (url != null) {
                        final uri = Uri.parse(url);
                        await launchUrl(uri);
                      } else {
                        Get.snackbar(
                          "Kesalahan",
                          "Format tanggal tidak valid.",
                          colorText: Colors.black,
                        );
                        return;
                      }
                    },
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
                      'a': Style(
                        textDecoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
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
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        getDataArticle.tag.map((tag) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 2,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Text(
                                "#$tag",
                                style: AppFonts().normalWhiteTagFont,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: RichText(
                    text: TextSpan(
                      text: "Sumber: ",
                      style: AppFonts().normalBlackBoldFont,
                      children: [
                        TextSpan(
                          text: getDataArticle.source,
                          style: AppFonts().normalBlackFont,
                        ),
                      ],
                    ),
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
