import 'package:sunnly/domain/entities/location.dart';
import 'package:sunnly/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(Location location);
}
