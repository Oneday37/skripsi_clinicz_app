class OnlineArticlesModel {
  String idArticle;
  String titleArticle;
  String dateArticle;
  String imageArticle;
  List tagArticle;

  OnlineArticlesModel({
    required this.idArticle,
    required this.titleArticle,
    required this.dateArticle,
    required this.imageArticle,
    required this.tagArticle,
  });

  factory OnlineArticlesModel.fromJson(Map<String, dynamic> json) {
    return OnlineArticlesModel(
      idArticle: json['id'] ?? "Artikel tidak memiliki id",
      titleArticle: json['title'] ?? "Artikel tidak memiliki judul",
      dateArticle: json['date'] ?? "-",
      imageArticle: json['img'],
      tagArticle: List.from(json["tag"].map((x) => x)),
    );
  }
}
