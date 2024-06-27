class Location {
  final double latitude;
  final double longitude;
  final String name;

  const Location(
      {required this.latitude, required this.longitude, required this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    double latitude = json["results"][0]["latitude"];
    double longitude = json["results"][0]["longitude"];
    String name = json["results"][0]["name"];

    return Location(latitude: latitude, longitude: longitude, name: name);
  }
}
