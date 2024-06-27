import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogodabezradar/location/Location.dart';
import 'package:pogodabezradar/location/LocationService.dart';
import 'package:pogodabezradar/weather/Weather.dart';
import 'package:pogodabezradar/weather/WeatherService.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<Weather>? futureWeather;
  Location? location;

  @override
  void initState() {
    super.initState();
    _loadLocationAndFetchWeather();
  }

  Future<void> _loadLocationAndFetchWeather() async {
    try {
      var locationService = await LocationService.create();
      var location = await locationService.getLocationFromBox();
      setState(() {
        futureWeather = WeatherService()
            .getWeather(location['latitude'], location['longitude']);
      });
    } catch (e) {
      print('Error loading location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Container(
        alignment: Alignment.center,
        child: futureWeather == null
            ? const CircularProgressIndicator()
            : FutureBuilder<Weather>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  ;
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            // if (location != null)
                            //   Text(
                            //     'Location: ${location?['name']}',
                            //     style: TextStyle(fontSize: 20),
                            //   ),
                            Text(
                              "${snapshot.data!.temperature.round().toString()}°C",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 46,
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Image.asset(
                                "assets/img/cloudy_sunny.png",
                                width: 186,
                                height: 186,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${snapshot.data?.weatherDescription["day"][0]}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  ...snapshot.data!.hourlyWeather
                                      .map((element) {
                                    String formattedTime =
                                        DateFormat.Hm().format(element.time);

                                    return Container(
                                      width: 100,
                                      height: 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${element.temperature.round()}°C",
                                            style:
                                                const TextStyle(fontSize: 20),
                                            textAlign: TextAlign.start,
                                          ),
                                          Image.asset(
                                            "assets/img/cloudy_sunny.png",
                                            width: 80,
                                            height: 80,
                                          ),
                                          Divider(color: Colors.blue[100]),
                                          Text(
                                            formattedTime,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
      ),
    );
  }
}
