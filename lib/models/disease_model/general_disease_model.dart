class GeneralDiseaseModel {
  final String nama;
  final String deskripsi;
  String? kategori;

  GeneralDiseaseModel({
    required this.nama,
    required this.deskripsi,
    this.kategori,
  });

  factory GeneralDiseaseModel.fromJson(Map<String, dynamic> json) {
    return GeneralDiseaseModel(
      nama: json["nama"] ?? "",
      deskripsi: json["deskripsi"] ?? "",
      kategori: json["kategori"] ?? "",
    );
  }
}
