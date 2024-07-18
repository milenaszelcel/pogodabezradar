class HourlyWeather {
  final DateTime time;
  final double temperature;
  final dynamic weatherImage;
  final String isDayOrNight;

  const HourlyWeather(
      {required this.time,
      required this.temperature,
      required this.weatherImage,
      required this.isDayOrNight});
}
