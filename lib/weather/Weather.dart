import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pogodabezradar/weather/weatherDetails.dart';

class Weather {
  final double temperature;
  final List<HourlyWeather> hourlyWeather;
  final dynamic weatherDescription;
  final String isDayOrNight;

  const Weather(
      {required this.temperature,
      required this.hourlyWeather,
      required this.weatherDescription,
      required this.isDayOrNight});

  factory Weather.fromJson(Map<String, dynamic> json) {
    double temperature = json['current']['temperature_2m'];
    List<String> times = List<String>.from(json['hourly']['time']);
    List<double> temperatures =
        List<double>.from(json['hourly']['temperature_2m']);
    List<int> weatherCodes = List<int>.from(json['hourly']['weather_code']);
    List<int> daysOrNights = List<int>.from(json['hourly']['is_day']);
    String code = json['current']['weather_code'].toString();
    var weatherDescription = getWeatherData(code);
    String isDayOrNight = json['current']['is_day'] == 1 ? "day" : "night";

    List<HourlyWeather> hourlyWeather = List<HourlyWeather>.generate(
      times.length,
      (index) => HourlyWeather(
          time: DateTime.parse(times[index]),
          temperature: temperatures[index],
          weatherImage: getWeatherData(weatherCodes[index].toString()),
          isDayOrNight: daysOrNights[index] == 1 ? "day" : "night"),
    );
    hourlyWeather.sort((a, b) {
      String aLabel = getDayLabel(a.time);
      String bLabel = getDayLabel(b.time);
      return dayLabelOrder[aLabel]!.compareTo(dayLabelOrder[bLabel]!);
    });
    return Weather(
        temperature: temperature,
        hourlyWeather: hourlyWeather,
        weatherDescription: weatherDescription,
        isDayOrNight: isDayOrNight);
  }
}

class HourlyWeather {
  final DateTime time;
  final double temperature;
  final dynamic weatherImage;
  final String isDayOrNight;

  const HourlyWeather(
      {required this.time,
      required this.temperature,
      required this.weatherImage,
      required this.isDayOrNight});
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
        "night": [dayDescription, nightImage]
      };
    } else {
      print("Data for day or night is missing.");
    }
  } else {
    print("Weather code $code not found.");
  }
}

String getDayLabel(DateTime date) {
  DateTime now = DateTime.now();
  if (DateFormat('yyyy-MM-dd').format(date) ==
      DateFormat('yyyy-MM-dd').format(now)) {
    return "Dziś";
  } else if (DateFormat('yyyy-MM-dd').format(date) ==
      DateFormat('yyyy-MM-dd').format(now.add(Duration(days: 1)))) {
    return "Jutro";
  } else {
    return DateFormat('EEEE')
        .format(date); // Display the day of the week for other days
  }
}

Map<String, int> dayLabelOrder = {
  "Dziś": 0,
  "Jutro": 1,
  "Poniedziałek": 2,
  "Wtorek": 3,
  "Środa": 4,
  "Czwartek": 5,
  "Piątek": 6,
  "Sobota": 7,
  "Niedziela": 8
};
