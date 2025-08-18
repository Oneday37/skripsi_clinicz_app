class HistoryDiseasePredictionModel {
  String id;
  String type;
  String gejala;
  List<Detail> detail;

  HistoryDiseasePredictionModel({
    required this.id,
    required this.type,
    required this.gejala,
    required this.detail,
  });

  factory HistoryDiseasePredictionModel.fromJson(Map<String, dynamic> json) {
    return HistoryDiseasePredictionModel(
      id: json["id"] ?? "-",
      type: json["type"] ?? "-",
      gejala: json["gejala"] ?? "-",
      detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
    );
  }
}

class Detail {
  String namaPenyakit;

  Detail({required this.namaPenyakit});

  factory Detail.fromJson(Map<String, dynamic> json) =>
      Detail(namaPenyakit: json["penyakit"] ?? "-");
}
