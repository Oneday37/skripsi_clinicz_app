class NearbyClinicsModel {
  String name;
  String address;
  double lat;
  double lng;
  double distance;
  TagsModel tags;
  String mapLink;

  NearbyClinicsModel({
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.distance,
    required this.tags,
    required this.mapLink,
  });

  factory NearbyClinicsModel.fromJson(Map<String, dynamic> json) {
    return NearbyClinicsModel(
      name: json["name"],
      address: json["address"],
      lat: json["lat"],
      lng: json["lng"],
      distance: json["distance"],
      tags: TagsModel.fromJson(json["tags"]),
      mapLink: json["mapLink"],
    );
  }
}

class TagsModel {
  String address;
  String amenity;
  String building;
  String buildingName;
  String wheelchair;

  TagsModel({
    required this.address,
    required this.amenity,
    required this.building,
    required this.buildingName,
    required this.wheelchair,
  });

  factory TagsModel.fromJson(Map<String, dynamic> json) {
    return TagsModel(
      address: json["addr:full"] ?? "-",
      amenity: json["amenity"] ?? "-",
      building: json["building"] ?? "-",
      buildingName: json["name"] ?? "-",
      wheelchair: json["wheelchair"] ?? "-",
    );
  }
}
