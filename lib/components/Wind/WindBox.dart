import 'package:flutter/material.dart';
import 'package:pogodabezradar/weather/WeatherDataModels/Wind.dart';

class WindBox extends StatelessWidget {
  final dynamic data;
  const WindBox({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        children: [
          Container(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
              child: Text(
                "Wiatr",
                style: TextStyle(color: Colors.blue[600], fontSize: 18),
              ),
            ),
          ),
          Divider(color: Colors.blue[100]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                     
                     
                      SizedBox(
                        child: Image.asset(
                          'assets/img/weather_img/wind.png',
                          width: 120.0,
                        ),
                      ),
                       SizedBox(
                        width: 50,
                      ),
                       Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "${data.windSpeed.toString()}km/h",
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Porywy wiatru do ${data.windGusts.toString()}km/h",
                  style: TextStyle(color: Color.fromARGB(255, 252, 94, 55)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
