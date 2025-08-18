class HistoryDrugModel {
  String id;
  String type;
  String penyakit;
  List<Detail> detail;

  HistoryDrugModel({
    required this.id,
    required this.type,
    required this.penyakit,
    required this.detail,
  });

  factory HistoryDrugModel.fromJson(Map<String, dynamic> json) {
    return HistoryDrugModel(
      id: json["id"] ?? "-",
      type: json["type"] ?? "-",
      penyakit: json["penyakit"] ?? "-",
      detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
    );
  }
}

class Detail {
  String namaObat;

  Detail({required this.namaObat});

  factory Detail.fromJson(Map<String, dynamic> json) =>
      Detail(namaObat: json["obat"] ?? "-");
}
