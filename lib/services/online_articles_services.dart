import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skripsi_clinicz_app/models/online_articles_model.dart';

class OnlineArticlesServices {
  final String baseUrl =
      "https://unfortunate-odessa-tsukasa-org-926b4973.koyeb.app/article";

  // METHOD GET ALL ARTICLES
  Future<List<OnlineArticlesModel>> getAllArticles() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List responseBody = jsonDecode(response.body);
      final result =
          responseBody.map((e) => OnlineArticlesModel.fromJson(e)).toList();
      return result;
    } else {
      throw Exception("Failed to load data");
    }
  }

  // METHOD GET ONE ARTICLES
  Future<OnlineSingleArticlesModel> getSingleArticle(String articleId) async {
    final response = await http.get(Uri.parse("$baseUrl/$articleId"));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return OnlineSingleArticlesModel.fromJson(responseBody);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
