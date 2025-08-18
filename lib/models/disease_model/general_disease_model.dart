class GeneralDiseaseModel {
  final String namaPenyakit;
  final String deskripsiPenyakit;
  String? kategoriPenyakit;

  GeneralDiseaseModel({
    required this.namaPenyakit,
    required this.deskripsiPenyakit,
    this.kategoriPenyakit,
  });

  factory GeneralDiseaseModel.fromJson(Map<String, dynamic> json) {
    return GeneralDiseaseModel(
      namaPenyakit: json["nama"] ?? "-",
      deskripsiPenyakit: json["deskripsi"] ?? "-",
      kategoriPenyakit: json["kategori"] ?? "-",
    );
  }
}
