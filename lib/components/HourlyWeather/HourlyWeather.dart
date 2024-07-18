import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogodabezradar/components/HourlyWeather/HourlyWeatherBox.dart';
import 'package:pogodabezradar/weather/Weather.dart';
import 'package:pogodabezradar/weather/WeatherDataModels/HourlyWeatherModel.dart';

class Hourlyweather extends StatelessWidget {
  final Weather? data;
  final DateTime currentTime = DateTime.now();

  Hourlyweather({super.key, required this.data});

  get temperature => null;

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
          child: Row(
            children: data!.hourlyWeather.entries.map<Widget>((entry) {
              String label = entry.key;

              List<HourlyWeather> weatherList = entry.value;

              List<HourlyWeather> filteredWeatherList = weatherList
                  .where((element) => element.time.isAfter(currentTime))
                  .toList();
              if (filteredWeatherList.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Text(
                        label,
                        style: TextStyle(color: Colors.blue[600], fontSize: 16),
                      ),
                    ),
                    Row(
                      children: filteredWeatherList.map<Widget>((element) {
                        String formattedTime =
                            DateFormat.Hm().format(element.time);
                        return HourlyWeatherBox(
                            element: element, formattedTime: formattedTime);
                      }).toList(),
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            }).toList(),
          ),
        ),
      ),
    );
  }
}
