class OnlineSingleArticlesModel {
  String idArticle;
  String titleArticle;
  String dateArticle;
  String contentArticle;
  String imageArticle;
  List tagArticle;
  DoctorModel doctorName;
  String source;
  String url;

  OnlineSingleArticlesModel({
    required this.idArticle,
    required this.titleArticle,
    required this.dateArticle,
    required this.contentArticle,
    required this.imageArticle,
    required this.tagArticle,
    required this.doctorName,
    required this.source,
    required this.url,
  });

  factory OnlineSingleArticlesModel.fromJson(Map<String, dynamic> json) {
    return OnlineSingleArticlesModel(
      idArticle: json['id'] ?? "Artikel tidak memiliki id",
      titleArticle: json['title'] ?? "Artikel tidak memiliki judul",
      dateArticle: json['date'] ?? "-",
      contentArticle: json['content'] ?? "Artikel tidak memiliki konten",
      imageArticle:
          json['img'] ??
          "https://global.tamu.edu/getmedia/f8ee83c6-cb20-4df8-8221-dd8f9c995995/no_image.png?width=250&height=250&ext=.png",
      tagArticle: List<String>.from(json['tag']),
      doctorName: DoctorModel.fromJson(json['doctor']),
      source: json['source'] ?? "-",
      url: json['url'] ?? "-",
    );
  }
}

class DoctorModel {
  String name;
  String source;

  DoctorModel({required this.name, required this.source});

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json["name"] ?? "-",
      source: json["source"] ?? "-",
    );
  }
}
