class DetailDrugRecommendationModel {
  final String namaPenyakit;
  final String kategoriPenyakit;
  final String namaObat;
  final String deskripsiObat;
  final String kandunganObat;
  final String dosisObat;
  final String sumberInformasi;
  final String gambarObat;

  DetailDrugRecommendationModel({
    required this.namaPenyakit,
    required this.kategoriPenyakit,
    required this.namaObat,
    required this.deskripsiObat,
    required this.kandunganObat,
    required this.dosisObat,
    required this.sumberInformasi,
    required this.gambarObat,
  });

  factory DetailDrugRecommendationModel.fromJson(Map<String, dynamic> json) {
    return DetailDrugRecommendationModel(
      namaPenyakit: json["Penyakit"] ?? "Nama penyakit tidak ditemukan",
      kategoriPenyakit: json["Kategori"] ?? "Kategori penyakit tidak tersedia",
      namaObat: json["Obat"] ?? "Tidak ada nama obat untuk penyakit ini",
      deskripsiObat: json["Deskripsi"] ?? "Deskripsi obat tidak tersedia",
      kandunganObat: json["Kandungan"] ?? "Kandungan obat tidak tersedia",
      dosisObat: json["Dosis"] ?? "Dosis obat tidak tersedia",
      sumberInformasi: json["Sumber"] ?? "-",
      gambarObat:
          json["Gambar"] ??
          "https://kec-sipispis.serdangbedagaikab.go.id/administrator/assets/img/img_pelayanan/belumada2.jpg",
    );
  }
}
