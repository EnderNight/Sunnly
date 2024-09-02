import 'package:sunnly/data/datasources/weather/weather_local_data_source.dart';
import 'package:sunnly/data/datasources/weather/weather_remote_data_source.dart';
import 'package:sunnly/data/models/location_model.dart';
import 'package:sunnly/domain/entities/location.dart';
import 'package:sunnly/domain/entities/weather.dart';
import 'package:sunnly/domain/repositories/weather_repository.dart';

class IWeatherRepository implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;

  IWeatherRepository(
    this.remoteDataSource,
    this.localDataSource,
  );

  Future<void> _cleanWeathers() async {
    final weathers = await localDataSource.getWeathers();
    final now = DateTime.now();

    for (final weather in weathers) {
      if (now.difference(weather.recordTime).inMinutes >= 10) {
        localDataSource.deleteWeather(weather);
      }
    }
  }

  @override
  Future<Weather> getWeather(Location location) async {
    final locModel = LocationModel.fromEntity(location);

    final localWeather = await localDataSource.getWeather(locModel);

    if (localWeather != null &&
        DateTime.now().difference(localWeather.recordTime).inMinutes < 10) {
      return localWeather.toEntity(location);
    }

    final res = await remoteDataSource.getWeather(locModel);

    localDataSource.addWeather(res);

    _cleanWeathers();

    return res.toEntity(location);
  }
}
