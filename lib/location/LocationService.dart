import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pogodabezradar/env/env.dart';

class LocationService {
  Future getLocation(location) async {
    final response = await http.get(Uri.http(
        "https://geocoding-api.open-meteo.com/v1/search?name=$location&count=10&language=en&format=json"));
    if (response.statusCode == 200) {
      var body = response.body;
      print(body);
      // return Location.fromJson(jsonDecode(body));
    } else {
      throw Exception("Nie dziala");
    }
  }
}
