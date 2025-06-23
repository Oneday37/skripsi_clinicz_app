class AuthenthicationModel {
  final String username;
  final String email;
  final String password;
  final DateTime dateOfBirth;
  final String gender;
  final String profileImage;
  final String id;

  AuthenthicationModel({
    required this.username,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.gender,
    required this.profileImage,
    required this.id,
  });

  // Factory method to convert JSON to Dart object
  factory AuthenthicationModel.fromJson(Map<String, dynamic> json) {
    return AuthenthicationModel(
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'] ?? "",
      profileImage:
          json['profileImage'] ??
          "https://itbox.id/wp-content/uploads/2022/11/cara-mengatasi-error-404.jpeg",
      id: json['_id'],
    );
  }

  // Method to convert Dart object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'profileImage': profileImage,
      '_id': id,
    };
  }
}
