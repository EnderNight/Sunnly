import 'package:sunnly/entities/location.dart';

enum WeatherType {
  thunderstrom,
  drizzle,
  rain,
  snow,
  atmosphere,
  clear,
  clouds,
}

class Weather {
  final String id;
  final DateTime timeOfRecord;

  final double temperature;
  final WeatherType weatherType;
  final String description;
  final Location location;
  final List<Weather> forecast;

  const Weather({
    required this.id,
    required this.timeOfRecord,
    required this.temperature,
    required this.weatherType,
    required this.description,
    required this.location,
    required this.forecast,
  });
}
