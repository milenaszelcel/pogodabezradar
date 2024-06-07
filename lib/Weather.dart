class Weather {
  final double temperature;
  final List<HourlyWeather> hourlyWeather;

  const Weather({
    required this.temperature,
    required this.hourlyWeather,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    double temperature = json['current']['temperature_2m'];
    List<String> times = List<String>.from(json['hourly']['time']);
    List<double> temperatures =
        List<double>.from(json['hourly']['temperature_2m']);

    List<HourlyWeather> hourlyWeather = List<HourlyWeather>.generate(
      times.length,
      (index) => HourlyWeather(
        time: DateTime.parse(times[index]),
        temperature: temperatures[index],
      ),
    );

    return Weather(
      temperature: temperature,
      hourlyWeather: hourlyWeather,
    );
  }
}

class HourlyWeather {
  final DateTime time;
  final double temperature;

  const HourlyWeather({
    required this.time,
    required this.temperature,
  });
}
