class DetailDrugRecommendationModel {
  String id;
  String userId;
  String type;
  Input input;
  List<Output> output;
  DateTime createdAt;
  int v;

  DetailDrugRecommendationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.input,
    required this.output,
    required this.createdAt,
    required this.v,
  });

  factory DetailDrugRecommendationModel.fromJson(Map<String, dynamic> json) {
    return DetailDrugRecommendationModel(
      id: json["_id"],
      userId: json["userId"],
      type: json["type"],
      input: Input.fromJson(json["input"]),
      output: List<Output>.from(json["output"].map((x) => Output.fromJson(x))),
      createdAt: DateTime.parse(json["createdAt"]),
      v: json["__v"],
    );
  }
}

class Input {
  String penyakit;

  Input({required this.penyakit});

  factory Input.fromJson(Map<String, dynamic> json) =>
      Input(penyakit: json["penyakit"]);
}

class Output {
  String obat;
  String deskripsi;
  String kandungan;
  String dosis;
  String aturanPakai;
  String efekSamping;
  List<LinkStore> tokoOnline1;
  List<LinkStore> tokoOnline2;
  double similarity;
  String pesan;

  Output({
    required this.obat,
    required this.deskripsi,
    required this.kandungan,
    required this.dosis,
    required this.aturanPakai,
    required this.efekSamping,
    required this.tokoOnline1,
    required this.tokoOnline2,
    required this.similarity,
    required this.pesan,
  });

  factory Output.fromJson(Map<String, dynamic> json) {
    return Output(
      obat: json["obat"] ?? "Tidak ada nama obat untuk penyakit ini",
      deskripsi: json["deskripsi"] ?? "Deskripsi obat tidak tersedia",
      kandungan: json["kandungan"] ?? "-",
      dosis: json["dosis"] ?? "-",
      aturanPakai: json["aturanPakai"] ?? "-",
      efekSamping: json["efekSamping"] ?? "-",
      tokoOnline1:
          (json["tokoOnline1"] ?? [])
              .map<LinkStore>((x) => LinkStore.fromJson(x))
              .toList(),
      tokoOnline2:
          (json["tokoOnline2"] ?? [])
              .map<LinkStore>((x) => LinkStore.fromJson(x))
              .toList(),
      similarity: json["similarity"]?.toDouble(),
      pesan: json["pesan"] ?? "",
    );
  }
}

class LinkStore {
  String toko;
  String url;

  LinkStore({required this.toko, required this.url});

  factory LinkStore.fromJson(Map<String, dynamic> json) {
    return LinkStore(toko: json["Toko"], url: json["Link"]);
  }
}
