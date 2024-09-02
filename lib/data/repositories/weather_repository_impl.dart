import 'package:sunnly/data/datasources/weather_remote_data_source.dart';
import 'package:sunnly/data/models/location_model.dart';
import 'package:sunnly/domain/entities/location.dart';
import 'package:sunnly/domain/entities/weather.dart';
import 'package:sunnly/domain/repositories/weather_repository.dart';

class IWeatherRepository implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  const IWeatherRepository(this.remoteDataSource);

  @override
  Future<Weather> getWeather(Location location) async {
    final locModel = LocationModel.fromEntity(location);

    final res = await remoteDataSource.getWeather(locModel);

    return res.toEntity();
  }
}
