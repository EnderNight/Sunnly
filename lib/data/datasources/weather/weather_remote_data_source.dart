import 'dart:convert';

import 'package:sunnly/core/keys.dart';
import 'package:sunnly/core/strings.dart';
import 'package:sunnly/data/models/location_model.dart';
import 'package:sunnly/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(LocationModel location) async {
    final url = Uri.http(
      openWeatherMapAuthority,
      currentWeatherPath,
      {
        'lat': location.lat.toString(),
        'lon': location.lon.toString(),
        'units': 'metric',
        'appid': openweathermapApiKey,
      },
    );

    final response = await http.get(url);

    assert(response.statusCode == 200, "Error in weather request");

    return WeatherModel.fromJson(
        jsonDecode(response.body) as Map, location.name, []);
  }
}
