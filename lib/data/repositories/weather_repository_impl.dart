import 'package:sunnly/domain/entities/weather.dart';
import 'package:sunnly/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<Weather> getWeather(double lat, double lon) {
    // TODO: implement getWeather
    throw UnimplementedError();
  }
}
