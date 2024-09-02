import 'package:sunnly/domain/entities/location.dart';
import 'package:sunnly/domain/entities/weather.dart';
import 'package:sunnly/domain/repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  const GetWeather(this.repository);

  Future<Weather> call(Location location) async {
    return await repository.getWeather(location);
  }
}
