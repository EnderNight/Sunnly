import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:sunnly/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  // ignore: non_constant_identifier_names
  final String BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  const WeatherService({
    required this.apiKey,
  });

  Future<(double, double)> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions denied forever. The app cannot work without them.");
    }

    Position position = await Geolocator.getCurrentPosition();

    return (position.latitude, position.longitude);
  }

  Future<Weather> fetchWeather() async {
    var (latitude, longitude) = await getPosition();

    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${latitude.toString()}&lon=${longitude.toString()}&appid=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("Failed to get weather");
    }
  }
}
