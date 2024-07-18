class DailyWeather {
  final DateTime date;
  final double maxTemperature;
  final double minTemperature;
  final dynamic weatherImage;
  final String isDayOrNight = "day";

  DailyWeather({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.weatherImage,
  });
}
