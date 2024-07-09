enum WeatherType {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere,
  clear,
  clouds;

  factory WeatherType.fromString(String type) {
    switch (type) {
      case 'thunderstorm':
        return WeatherType.thunderstorm;
      case 'drizzle':
        return WeatherType.drizzle;
      case 'rain':
        return WeatherType.rain;
      case 'snow':
        return WeatherType.snow;
      case 'atmosphere':
        return WeatherType.atmosphere;
      case 'clouds':
        return WeatherType.clouds;
      default:
        return WeatherType.clear;
    }
  }
}

class Weather {
  final String cityName;
  final double temperature;
  final WeatherType weatherType;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.weatherType,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'] - 273.15, // Kelvin to Celsius
      weatherType: WeatherType.fromString(
        json['weather'][0]['main'],
      ),
    );
  }
}
