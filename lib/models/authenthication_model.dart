class AuthenthicationModel {
  final String id;
  final String username;
  final String email;
  final DateTime dateOfBirth;
  final String gender;
  final String profileImage;

  AuthenthicationModel({
    required this.id,
    required this.username,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.profileImage,
  });

  factory AuthenthicationModel.fromJson(Map<String, dynamic> json) {
    return AuthenthicationModel(
      id: json['_id'],
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender:
          json['gender'].toString()[0].toUpperCase() +
          json['gender'].toString().substring(1),
      profileImage:
          json['profileImage'] != ""
              ? "https://unfortunate-odessa-tsukasa-org-926b4973.koyeb.app${json['profileImage']}"
              : "https://pbs.twimg.com/profile_images/1321030814436655106/87OcbZNm_400x400.jpg",
    );
  }
}
