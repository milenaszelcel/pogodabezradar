import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pogodabezradar/weather/WeatherDataModels/HourlyWeatherModel.dart';
import 'package:pogodabezradar/weather/WeatherDataModels/WeatherDescription.dart';
import 'package:pogodabezradar/weather/WeatherDataModels/Wind.dart';
import 'package:pogodabezradar/weather/weatherDetails.dart';

import 'WeatherDataModels/DailyWeather.dart';

class Weather {
  final double temperature;
  final Map<String, List<HourlyWeather>> hourlyWeather;
  final dynamic weatherDescription;
  final String isDayOrNight;
  final List<DailyWeather> dailyWeather;
  final Wind wind;

  const Weather(
      {required this.temperature,
      required this.hourlyWeather,
      required this.weatherDescription,
      required this.isDayOrNight,
      required this.dailyWeather,
      required this.wind});

  factory Weather.fromJson(Map<String, dynamic> json) {
    //Current weather
    double temperature = json['current']['temperature_2m'];
    String code = json['current']['weather_code'].toString();
    dynamic weatherDescription = getWeatherData(code);
    String isDayOrNight = json['current']['is_day'] == 1 ? "day" : "night";
    //Wind
    double windSpeed = json['current']['wind_speed_10m'];
    double windGusts = json['current']['wind_gusts_10m'];
    Wind wind = Wind(windGusts: windGusts, windSpeed: windSpeed);

    //HourlyWeather
    List<String> times = List<String>.from(json['hourly']['time']);
    List<double> temperatures =
        List<double>.from(json['hourly']['temperature_2m']);
    List<int> weatherCodes = List<int>.from(json['hourly']['weather_code']);
    List<int> daysOrNights = List<int>.from(json['hourly']['is_day']);
    Map<String, List<HourlyWeather>> labeledWeather = {
      'Dziś': [],
      'Jutro': [],
    };
    List<HourlyWeather> hourlyWeather = List<HourlyWeather>.generate(
      times.length,
      (index) => HourlyWeather(
          time: DateTime.parse(times[index]),
          temperature: temperatures[index],
          weatherImage: getWeatherData(weatherCodes[index].toString()),
          isDayOrNight: daysOrNights[index] == 1 ? "day" : "night"),
    );

    for (var weather in hourlyWeather) {
      String label = getDataLabel(weather.time);
      if (labeledWeather.containsKey(label)) {
        labeledWeather[label]!.add(weather);
      }
    }

    //DailyWeather
    List<String> dates = List<String>.from(json['daily']['time']);
    List<int> dailyCodes = List<int>.from(json['daily']['weather_code']);
    List<double> maxTemperatures =
        List<double>.from(json['daily']['temperature_2m_max']);
    List<double> minTemperatures =
        List<double>.from(json['daily']['temperature_2m_min']);

    List<DailyWeather> dailyWeather = List<DailyWeather>.generate(
        dates.length,
        (index) => DailyWeather(
            date: DateTime.parse(dates[index]),
            maxTemperature: maxTemperatures[index],
            minTemperature: minTemperatures[index],
            weatherImage: getWeatherData(dailyCodes[index].toString())));

    return Weather(
      temperature: temperature,
      hourlyWeather: labeledWeather,
      weatherDescription: weatherDescription,
      isDayOrNight: isDayOrNight,
      dailyWeather: dailyWeather,
      wind: wind,
    );
  }
}

getWeatherData(String code) {
  if (weatherData.containsKey(code)) {
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

getDataLabel(DateTime date) {
  DateTime currentTime = DateTime.now();
  DateTime today =
      DateTime(currentTime.year, currentTime.month, currentTime.day);
  DateTime targetDate = DateTime(date.year, date.month, date.day);
  String label;

  int differenceInDays = targetDate.difference(today).inDays;

  if (differenceInDays == 0) {
    label = "Dziś";
  } else if (differenceInDays == 1) {
    label = "Jutro";
  } else if (differenceInDays == 2) {
    label = "Pojutrze";
  } else {
    label = "other";
  }
  return label;
}
