import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pogodabezradar/Weather.dart';
import 'package:pogodabezradar/env/env.dart';

class WeatherService {
  Future<Weather> getWeather() async {
    final response = await http.get(Uri.parse(Env.url));
    if (response.statusCode == 200) {
      var body = response.body;
      print(body);
      return Weather.fromJson(jsonDecode(body));
    } else {
      throw Exception("Nie dziala");
    }
  }
}
