import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'DailyWeather.dart';

class DailyWeatherBox extends StatelessWidget {
  final dynamic element;
  final String formattedTime;
  

  const DailyWeatherBox(
      {super.key, required this.element, required this.formattedTime});

  @override
  Widget build(BuildContext context) {
    String dayAndMonth = DateFormat('MMMd', 'pl_PL').format(element.date);
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${dayAndMonth}"),
          Divider(color: Colors.blue[100]),
          Text(
            formattedTime,
            style: const TextStyle(fontSize: 16),
          ),
          Image.asset(
            element.weatherImage[element.isDayOrNight][1],
            width: 80,
            height: 100,
          ),
          Divider(color: Colors.blue[100]),
          Text(
            "${element.maxTemperature.round()}°C",
            style: const TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 252, 94, 55)),
            textAlign: TextAlign.start,
          ),
          Text(
            "${element.minTemperature.round()}°C",
            style: TextStyle(fontSize: 20, color: Colors.blue[600]),
          ),
        ],
      ),
    );
    ;
  }
}
