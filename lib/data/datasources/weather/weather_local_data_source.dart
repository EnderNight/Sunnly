import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunnly/data/models/location_model.dart';
import 'package:sunnly/data/models/weather_model.dart';

class WeatherLocalDataSource {
  final Box<WeatherModel> weatherBox;

  const WeatherLocalDataSource(this.weatherBox);

  Future<WeatherModel?> getWeather(LocationModel location) async {
    return weatherBox.values
        .where((weather) => weather.locationName == location.name)
        .firstOrNull;
  }

  Future<void> addWeather(WeatherModel weather) async {
    await weatherBox.put(weather.id, weather);
  }

  Future<List<WeatherModel>> getWeathers() async {
    return weatherBox.values.toList();
  }

  Future<void> deleteWeather(WeatherModel weather) async {
    await weatherBox.delete(weather.id);
  }
}
