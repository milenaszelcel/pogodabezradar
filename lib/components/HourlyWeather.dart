import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogodabezradar/components/OneHourBox.dart';
import 'package:pogodabezradar/weather/Weather.dart';

class Hourlyweather extends StatelessWidget {
  final Weather? data;
  final DateTime currentTime = DateTime.now();

  Hourlyweather({super.key, required this.data});

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
          child: Row(
            children: data!.hourlyWeather.entries.map<Widget>((entry) {
              String label = entry.key;

              List<HourlyWeather> weatherList = entry.value;

              List<HourlyWeather> filteredWeatherList = weatherList
                  .where((element) => element.time.isAfter(currentTime))
                  .toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 30),
                      child: Text(
                        label,
                        style: TextStyle(color: Colors.grey[800], fontSize: 16),
                      ),
                    ),
                  ),
                  Row(
                    children: filteredWeatherList.map<Widget>((element) {
                      return OneHourbox(element: element);
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
