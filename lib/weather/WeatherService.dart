import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pogodabezradar/weather/Weather.dart';


class WeatherService {
  Future<Weather> getWeather(latitude, longitude) async {
    final response = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,is_day,weather_code,wind_speed_10m,wind_direction_10m,wind_gusts_10m&hourly=temperature_2m,weather_code,is_day&daily=weather_code,temperature_2m_max,temperature_2m_min'));
    if (response.statusCode == 200) {
      var body = response.body;

      return Weather.fromJson(jsonDecode(body));
    } else {
      throw Exception("Nie dziala");
    }
  }
}
