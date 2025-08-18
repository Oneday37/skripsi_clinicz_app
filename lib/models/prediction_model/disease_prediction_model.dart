class DiseasePredictionModel {
  late String namaPenyakit;
  late String deskripsiPenyakit;

  DiseasePredictionModel({
    required this.namaPenyakit,
    required this.deskripsiPenyakit,
  });

  factory DiseasePredictionModel.fromJson(Map<String, dynamic> json) {
    return DiseasePredictionModel(
      namaPenyakit: json['penyakit'] ?? "Nama Penyakit tidak tercantum",
      deskripsiPenyakit:
          json['deskripsi'] ?? "Deskripsi Penyakit tidak tercantum",
    );
  }
}
