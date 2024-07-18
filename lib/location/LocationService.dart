import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:pogodabezradar/location/Location.dart';

class LocationService {
  LazyBox box;

  LocationService._(this.box);

  static Future<LocationService> create() async {
    var box = await Hive.openLazyBox('storageBox');
    return LocationService._(box);
  }

  Future getLocationAndSave(location) async {
    final response = await http.get(Uri.parse(
        "https://geocoding-api.open-meteo.com/v1/search?name=$location&count=10&language=pl&format=json"));
    if (response.statusCode == 200) {
      var body = response.body;
      location = Location.fromJson(jsonDecode(body));

      box.put('location', {
        'name': location.name,
        'latitude': location.latitude,
        'longitude': location.longitude,
      });
    } else {
      throw Exception("Nie dziala");
    }
  }

  Future getLocationFromBox() {
    return box.get('location');
  }
}
