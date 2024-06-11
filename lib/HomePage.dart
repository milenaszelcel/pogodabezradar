import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pogodabezradar/Weather.dart';
import 'package:pogodabezradar/WeatherService.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = WeatherService().getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Container(
          alignment: Alignment.center,
          child: FutureBuilder<Weather>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Stack(alignment: AlignmentDirectional.topStart, children: [
                      Text(
                        "${snapshot.data!.temperature.round().toString()}°C",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 46),
                      ),
                      SizedBox(
                        width: 300,
                        child: Image.asset(
                          "assets/img/cloudy_sunny.png",
                          width: 186,
                          height: 186,
                        ),
                      )
                    ]),
                    Scrollbar(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...snapshot.data!.hourlyWeather.map((element) {
                                  String formattedTime =
                                      DateFormat.Hm().format(element.time);
                                  return Container(
                                    color: Colors.white,
                                    width: 100,
                                    height: 180,
                                    child: Text(
                                      "${element.temperature}°C  $formattedTime ",
                                    ),
                                  );
                                })
                              ],
                            )))
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spiner.n
              return const CircularProgressIndicator();
            },
          )),
    );
  }
}
