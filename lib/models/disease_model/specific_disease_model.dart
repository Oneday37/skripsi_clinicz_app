class SpecificDiseaseModel {
  String namaPenyakit;
  String deskripsiPenyakit;
  String penyebabPenyakit;
  String pencegahanPenyakit;
  String sumberInformasi;

  SpecificDiseaseModel({
    required this.namaPenyakit,
    required this.deskripsiPenyakit,
    required this.penyebabPenyakit,
    required this.pencegahanPenyakit,
    required this.sumberInformasi,
  });

  factory SpecificDiseaseModel.fromJson(Map<String, dynamic> json) {
    return SpecificDiseaseModel(
      namaPenyakit: json["nama"] ?? "-",
      deskripsiPenyakit: json["deskripsi"] ?? "-",
      penyebabPenyakit: json["penyebab"] ?? "-",
      pencegahanPenyakit: json["pencegahan"] ?? "-",
      sumberInformasi: json["sumber"] ?? "-",
    );
  }
}
