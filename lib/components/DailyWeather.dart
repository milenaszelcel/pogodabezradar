import 'package:flutter/material.dart';
import 'package:pogodabezradar/components/OneHourBox.dart';
import 'package:pogodabezradar/weather/Weather.dart';

class DailyWeatherBox extends StatelessWidget {
  final Weather? data;

  const DailyWeatherBox({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: data!.dailyWeather.map<Widget>((element) {
      return Text(element.maxTemperature.toString());
    }).toList());
  }
}
