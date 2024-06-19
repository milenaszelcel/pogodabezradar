import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pogodabezradar/weatherDetails.dart';

class Weather {
  final double temperature;
  final List<HourlyWeather> hourlyWeather;
  final dynamic weatherDescription;

  const Weather({
    required this.temperature,
    required this.hourlyWeather,
    required this.weatherDescription,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    double temperature = json['current']['temperature_2m'];
    List<String> times = List<String>.from(json['hourly']['time']);
    List<double> temperatures =
        List<double>.from(json['hourly']['temperature_2m']);
    String code = json['current']['weather_code'].toString();
    var weatherDescription = getWeatherData(code);
    List<HourlyWeather> hourlyWeather = List<HourlyWeather>.generate(
      times.length,
      (index) => HourlyWeather(
        time: DateTime.parse(times[index]),
        temperature: temperatures[index],
      ),
    );

    return Weather(
      temperature: temperature,
      hourlyWeather: hourlyWeather,
      weatherDescription: weatherDescription,
    );
  }
}

class HourlyWeather {
  final DateTime time;
  final double temperature;

  const HourlyWeather({
    required this.time,
    required this.temperature,
  });
}

class weatherDescription {
  final String description;
  final String image;

  const weatherDescription({required this.description, required this.image});
}

getWeatherData(String code) {
  // Check if the weather code exists in the map
  if (weatherData.containsKey(code)) {
    // Retrieve the data for the specified weather code
    var dayData = weatherData[code]?["day"];
    var nightData = weatherData[code]?["night"];

    if (dayData != null && nightData != null) {
      String dayDescription =
          dayData["description"] ?? "No description available";
      String dayImage = dayData["image"] ?? "No image available";

      String nightDescription =
          nightData["description"] ?? "No description available";
      String nightImage = nightData["image"] ?? "No image available";

      return {
        "day": [dayDescription, dayImage],
        "night": [dayDescription, dayImage]
      };
    } else {
      print("Data for day or night is missing.");
    }
  } else {
    print("Weather code $code not found.");
  }
}
