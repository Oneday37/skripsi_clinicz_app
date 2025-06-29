class HistoryModel {
  String id;
  String type;
  String nama;

  HistoryModel({required this.id, required this.type, required this.nama});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json["id"],
      type: json["type"],
      nama: json["nama"] ?? "",
    );
  }
}
