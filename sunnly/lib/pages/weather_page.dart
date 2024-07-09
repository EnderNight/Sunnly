import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

  String getWeatherAsset(Weather weather) {
    String path = "assets";

    switch (weather.weatherType) {
      case WeatherType.thunderstorm:
        return "$path/thunderstorm.json";
      case WeatherType.drizzle:
        return "$path/drizzle.json";
      case WeatherType.rain:
        return "$path/rain.json";
      case WeatherType.snow:
        return "$path/snow.json";
      case WeatherType.atmosphere:
        return "$path/atmosphere.json";
      case WeatherType.clouds:
        return "$path/clouds.json";
      case WeatherType.clear:
        return "$path/clear.json";
    }
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(weather.cityName,
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 2.0)),
                    Lottie.asset(getWeatherAsset(weather)),
                    Text(
                      "${weather.temperature.toStringAsFixed(1)}°C",
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 2.0),
                    ),
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
