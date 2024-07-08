import 'package:flutter/material.dart';
import 'package:sunnly/models/weather.dart';
import 'package:sunnly/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<Weather> futureWeather;
  final WeatherService weatherService =
      const WeatherService(apiKey: "031c9411c3a3ee2e85a2c5ec0e5b8eae");

  @override
  void initState() {
    super.initState();

    futureWeather = weatherService.fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Center(
        child: FutureBuilder(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Weather weather = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(weather.cityName),
                    Text("${weather.temperature.toStringAsFixed(1)}°C"),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return const CircularProgressIndicator();
          },
        ),
      )),
    );
  }
}
