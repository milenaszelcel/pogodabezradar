import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pogodabezradar/weather/Weather.dart';
import 'package:pogodabezradar/env/env.dart';

class WeatherService {
  Future<Weather> getWeather(latitude, longitude) async {
    final response = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,is_day,weather_code&hourly=temperature_2m&forecast_days=2'));
    if (response.statusCode == 200) {
      var body = response.body;
      print(body);
      return Weather.fromJson(jsonDecode(body));
    } else {
      throw Exception("Nie dziala");
    }
  }
}
