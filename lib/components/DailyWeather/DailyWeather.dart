import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:pogodabezradar/components/DailyWeather/DailyWeatherBox.dart';
import 'package:pogodabezradar/components/HourlyWeather/HourlyWeatherBox.dart';
import 'package:pogodabezradar/weather/Weather.dart';

class DailyWeathers extends StatelessWidget {
  final Weather? data;

  DailyWeathers({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 10, bottom: 10),
                      child: Text(
                        "W tym tygodniu",
                        style: TextStyle(color: Colors.blue[600], fontSize: 18),
                      ),
                    ),
                    Row(
                        children: data!.dailyWeather.map<Widget>((element) {
                      String dayAndMonth = DateFormat.d().format(element.date);
                      String formattedDate =
                          DateFormat('EE', 'pl_PL').format(element.date);

                      return DailyWeatherBox(
                        element: element,
                        formattedTime: formattedDate,
                      );
                    }).toList())
                  ],
                ))));
  }
}
