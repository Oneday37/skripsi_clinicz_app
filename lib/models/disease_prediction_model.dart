class DiseasePredictionModel {
  final String penyakit;
  final String deskripsi;
  final String pengobatan;
  final String sumber;

  DiseasePredictionModel({
    required this.penyakit,
    required this.deskripsi,
    required this.pengobatan,
    required this.sumber,
  });

  factory DiseasePredictionModel.fromJson(Map<String, dynamic> json) {
    return DiseasePredictionModel(
      penyakit: json['penyakit'] ?? "Nama Penyakit tidak tercantum",
      deskripsi: json['deskripsi'] ?? "Deskripsi Penyakit tidak tercantum",
      pengobatan: json['pengobatan'] ?? "-",
      sumber: json['sumber'] ?? "Sumber Informasi Penyakit tidak tercantum",
    );
  }
}
