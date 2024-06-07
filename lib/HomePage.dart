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
      body: Container(
        color: Colors.yellow[700],
        child: FutureBuilder<Weather>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(
                    "Aktualnie jest: ${snapshot.data!.temperature.toString()} Stopni",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  ...snapshot.data!.hourlyWeather.map((element) {
                    String formattedTime = DateFormat.Hm().format(element.time);
                    return Text(
                      "Temperatura: ${element.temperature} Godzina: $formattedTime",
                      style: const TextStyle(color: Colors.white),
                    );
                  })
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spiner.n
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
