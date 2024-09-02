import 'package:sunnly/domain/entities/weather.dart';
import 'package:sunnly/domain/repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  const GetWeather(this.repository);

  Future<Weather> call(double lat, double lon) async {
    return await repository.getWeather(lat, lon);
  }
}
