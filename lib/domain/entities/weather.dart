import 'package:sunnly/domain/entities/location.dart';

enum WeatherType {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere,
  clear,
  clouds,
}

class Weather {
  final String id;
  final DateTime recordTime;
  final Location location;

  final double temperature;
  final WeatherType weatherType;
  final String description;
  final List<Weather> forecast;

  const Weather({
    required this.id,
    required this.recordTime,
    required this.temperature,
    required this.weatherType,
    required this.description,
    required this.location,
    required this.forecast,
  });
}
