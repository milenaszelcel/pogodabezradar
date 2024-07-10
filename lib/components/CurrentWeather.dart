import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogodabezradar/weather/Weather.dart';

class CurrentWeather extends StatelessWidget {
  final dynamic data;
  final dynamic location;

  CurrentWeather({required this.data, required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${location?["name"]}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          textAlign: TextAlign.start,
        ),
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Text(
              "${data.temperature.round().toString()}°C",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 42,
              ),
            ),
            SizedBox(
              width: 300,
              child: Image.asset(
                data.weatherDescription[data?.isDayOrNight][1],
                width: 186,
                height: 186,
              ),
            ),
          ],
        ),
        Text("${data?.weatherDescription[data?.isDayOrNight][0]}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
            )),
      ],
    );
  }
}
