class SpecificDiseaseModel {
  String nama;
  String deskripsi;
  String penyebab;
  String pencegahan;
  String sumber;

  SpecificDiseaseModel({
    required this.nama,
    required this.deskripsi,
    required this.penyebab,
    required this.pencegahan,
    required this.sumber,
  });

  factory SpecificDiseaseModel.fromJson(Map<String, dynamic> json) {
    return SpecificDiseaseModel(
      nama: json["nama"] ?? "",
      deskripsi: json["deskripsi"] ?? "",
      penyebab: json["penyebab"] ?? "",
      pencegahan: json["pencegahan"] ?? "",
      sumber: json["sumber"] ?? "",
    );
  }
}
