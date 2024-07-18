import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogodabezradar/weather/Weather.dart';

class HourlyWeatherBox extends StatelessWidget {
  dynamic element;
  String formattedTime;

  HourlyWeatherBox(
      {super.key, required this.element, required this.formattedTime});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(color: Colors.blue[100]),
          Text(
            "${element.temperature.round()}°C",
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.start,
          ),
          Image.asset(
            element.weatherImage[element.isDayOrNight][1],
            width: 80,
            height: 80,
          ),
          Divider(color: Colors.blue[100]),
          Text(
            formattedTime,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
