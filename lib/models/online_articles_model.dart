// MODEL FOR ARTICLES
class OnlineArticlesModel {
  String id;
  String title;
  String date;
  String img;
  List tag;

  OnlineArticlesModel({
    required this.id,
    required this.title,
    required this.date,
    required this.img,
    required this.tag,
  });

  factory OnlineArticlesModel.fromJson(Map<String, dynamic> json) {
    return OnlineArticlesModel(
      id: json['id'] ?? "Artikel tidak memiliki id",
      title: json['title'] ?? "Artikel tidak memiliki judul",
      date: json['date'] ?? "-",
      img: json['img'],
      tag: List.from(json["tag"].map((x) => x)),
    );
  }
}

// MODEL FOR SINGLE ARTICLES
class OnlineSingleArticlesModel {
  String id;
  String title;
  String date;
  String content;
  String img;
  List tag;
  DoctorModel doctor;
  String source;
  String url;

  OnlineSingleArticlesModel({
    required this.id,
    required this.title,
    required this.date,
    required this.content,
    required this.img,
    required this.tag,
    required this.doctor,
    required this.source,
    required this.url,
  });

  factory OnlineSingleArticlesModel.fromJson(Map<String, dynamic> json) {
    return OnlineSingleArticlesModel(
      id: json['id'] ?? "Artikel tidak memiliki id",
      title: json['title'] ?? "Artikel tidak memiliki judul",
      date: json['date'] ?? "-",
      content: json['content'] ?? "Artikel tidak memiliki konten",
      img:
          json['img'] ??
          "https://global.tamu.edu/getmedia/f8ee83c6-cb20-4df8-8221-dd8f9c995995/no_image.png?width=250&height=250&ext=.png",
      tag: List<String>.from(json['tag']),
      doctor: DoctorModel.fromJson(json['doctor']),
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
