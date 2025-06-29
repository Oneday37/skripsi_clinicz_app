class DetailDiseasePrediction {
  String id;
  String userId;
  String type;
  Input input;
  List<Output> output;
  DateTime createdAt;
  int v;

  DetailDiseasePrediction({
    required this.id,
    required this.userId,
    required this.type,
    required this.input,
    required this.output,
    required this.createdAt,
    required this.v,
  });

  factory DetailDiseasePrediction.fromJson(Map<String, dynamic> json) {
    return DetailDiseasePrediction(
      id: json["_id"] ?? "",
      userId: json["userId"] ?? "",
      type: json["type"] ?? "",
      input: Input.fromJson(json["input"]),
      output: List<Output>.from(json["output"].map((x) => Output.fromJson(x))),
      createdAt: DateTime.parse(json["createdAt"]),
      v: json["__v"],
    );
  }
}

class Input {
  String text;

  Input({required this.text});

  factory Input.fromJson(Map<String, dynamic> json) =>
      Input(text: json["text"]);
}

class Output {
  String penyakit;
  String deskripsi;
  String penyebab;
  String pencegahan;
  String sumber;

  Output({
    required this.penyakit,
    required this.deskripsi,
    required this.penyebab,
    required this.pencegahan,
    required this.sumber,
  });

  factory Output.fromJson(Map<String, dynamic> json) {
    return Output(
      penyakit: json["penyakit"] ?? "Nama Penyakit tidak tercantum",
      deskripsi: json["deskripsi"] ?? "Deskripsi Penyakit tidak tercantum",
      penyebab: json["penyebab"] ?? "-",
      pencegahan: json["pencegahan"] ?? "-",
      sumber: json["sumber"] ?? "Sumber Informasi Penyakit tidak tercantum",
    );
  }
}
