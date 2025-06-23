class PenyakitPrediction {
  final String penyakit;
  final String deskripsi;
  final String penyebab;
  final String pencegahan;
  final String sumber;

  PenyakitPrediction({
    required this.penyakit,
    required this.deskripsi,
    required this.penyebab,
    required this.pencegahan,
    required this.sumber,
  });

  factory PenyakitPrediction.fromJson(Map<String, dynamic> json) {
    return PenyakitPrediction(
      penyakit: json['penyakit'],
      deskripsi: json['deskripsi'],
      penyebab: json['penyebab'],
      pencegahan: json['pencegahan'],
      sumber: json['sumber'],
    );
  }
}
