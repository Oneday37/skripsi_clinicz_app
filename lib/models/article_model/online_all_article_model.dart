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
