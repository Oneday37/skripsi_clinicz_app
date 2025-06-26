class DiseasePredictionModel {
  final String penyakit;
  final String deskripsi;
  final String penyebab;
  final String pencegahan;
  final String sumber;

  DiseasePredictionModel({
    required this.penyakit,
    required this.deskripsi,
    required this.penyebab,
    required this.pencegahan,
    required this.sumber,
  });

  factory DiseasePredictionModel.fromJson(Map<String, dynamic> json) {
    return DiseasePredictionModel(
      penyakit: json['penyakit'] ?? "Nama Penyakit tidak tercantum",
      deskripsi: json['deskripsi'] ?? "Deskripsi Penyakit tidak tercantum",
      penyebab: json['penyebab'] ?? "-",
      pencegahan: json['pencegahan'] ?? "-",
      sumber: json['sumber'] ?? "Sumber Informasi Penyakit tidak tercantum",
    );
  }
}
