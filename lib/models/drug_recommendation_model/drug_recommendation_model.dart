class DrugRecommendationModel {
  final String namaObat;
  final String deskripsiObat;

  DrugRecommendationModel({
    required this.namaObat,
    required this.deskripsiObat,
  });

  factory DrugRecommendationModel.fromJson(Map<String, dynamic> json) {
    return DrugRecommendationModel(
      namaObat: json["obat"] ?? "Tidak ada nama obat untuk penyakit ini",
      deskripsiObat: json["deskripsi"] ?? "Deskripsi obat tidak tersedia",
    );
  }
}
