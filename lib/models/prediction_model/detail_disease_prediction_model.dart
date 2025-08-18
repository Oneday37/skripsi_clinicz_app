class DetailDiseasePredictionModel {
  late String namaPenyakit;
  late String deskripsiPenyakit;
  late String pengobatanPenyakit;
  late String sumberInformasi;

  DetailDiseasePredictionModel({
    required this.namaPenyakit,
    required this.deskripsiPenyakit,
    required this.pengobatanPenyakit,
    required this.sumberInformasi,
  });

  factory DetailDiseasePredictionModel.fromJson(Map<String, dynamic> json) {
    return DetailDiseasePredictionModel(
      namaPenyakit: json['nama'] ?? "Nama Penyakit tidak tercantum",
      deskripsiPenyakit:
          json['deskripsi'] ?? "Deskripsi Penyakit tidak tercantum",
      pengobatanPenyakit: json['pengobatan'] ?? "-",
      sumberInformasi:
          json['sumber'] ?? "Sumber Informasi Penyakit tidak tercantum",
    );
  }
}
