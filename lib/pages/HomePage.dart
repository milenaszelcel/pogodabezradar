import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogodabezradar/components/DailyWeather/DailyWeather.dart';
import 'package:pogodabezradar/components/HourlyWeather/HourlyWeather.dart';
import 'package:pogodabezradar/components/Wind/WindBox.dart';
import 'package:pogodabezradar/location/Location.dart';
import 'package:pogodabezradar/components/CurrentWeather.dart';
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
  dynamic location;

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
        this.location = location;
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
        child: futureWeather == null
            ? const CircularProgressIndicator()
            : FutureBuilder<Weather>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    return ListView(
                      children: [
                        CurrentWeather(data: snapshot.data, location: location),
                        Hourlyweather(data: snapshot.data),
                        DailyWeathers(data: snapshot.data),
                        WindBox(data: snapshot.data?.wind)
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
