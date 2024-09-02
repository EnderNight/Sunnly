import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sunnly/domain/entities/location.dart';
import 'package:sunnly/domain/entities/weather.dart';
import 'package:uuid/uuid.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 1)
class WeatherModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime recordTime;

  @HiveField(2)
  final String locationName;

  @HiveField(3)
  final int weatherId;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final double temperature;

  @HiveField(6)
  final List<WeatherModel> forecast;

  const WeatherModel({
    required this.id,
    required this.recordTime,
    required this.locationName,
    required this.weatherId,
    required this.description,
    required this.temperature,
    required this.forecast,
  });

  Weather toEntity(Location location) {
    return Weather(
      id: id,
      recordTime: recordTime,
      temperature: temperature,
      weatherType: _weatherIdToType(weatherId),
      description: description,
      location: location,
      forecast: forecast.map((ele) => ele.toEntity(location)).toList(),
    );
  }

  factory WeatherModel.fromEntity(Weather weather) {
    return WeatherModel(
      id: weather.id,
      recordTime: weather.recordTime,
      locationName: weather.location.name,
      weatherId: _weatherTypeToId(weather.weatherType),
      description: weather.description,
      temperature: weather.temperature,
      forecast:
          weather.forecast.map((ele) => WeatherModel.fromEntity(ele)).toList(),
    );
  }

  factory WeatherModel.fromJson(
    Map json,
    String locationName,
    List<WeatherModel> forecast,
  ) {
    return WeatherModel(
      id: GetIt.I.get<Uuid>().v4(),
      recordTime: DateTime.now(),
      locationName: locationName,
      weatherId: json["weather"][0]["id"],
      description: json["weather"][0]["description"],
      temperature: json["main"]["temp"],
      forecast: forecast,
    );
  }
}

WeatherType _weatherIdToType(int id) {
  return switch (id) {
    >= 200 && <= 232 => WeatherType.thunderstorm,
    >= 300 && <= 321 => WeatherType.drizzle,
    >= 500 && <= 531 => WeatherType.rain,
    >= 600 && <= 622 => WeatherType.snow,
    >= 701 && <= 781 => WeatherType.atmosphere,
    >= 801 && <= 804 => WeatherType.clouds,
    _ => WeatherType.clear
  };
}

int _weatherTypeToId(WeatherType type) {
  return switch (type) {
    WeatherType.thunderstorm => 200,
    WeatherType.drizzle => 300,
    WeatherType.rain => 500,
    WeatherType.snow => 600,
    WeatherType.atmosphere => 701,
    WeatherType.clear => 800,
    WeatherType.clouds => 801,
  };
}
