import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunnly/data/datasources/location/location_local_data_source.dart';
import 'package:sunnly/data/datasources/location/location_remote_data_source.dart';
import 'package:sunnly/data/datasources/weather/weather_local_data_source.dart';
import 'package:sunnly/data/datasources/weather/weather_remote_data_source.dart';
import 'package:sunnly/data/models/location_model.dart';
import 'package:sunnly/data/models/weather_model.dart';
import 'package:sunnly/data/repositories/location_repository_impl.dart';
import 'package:sunnly/data/repositories/weather_repository_impl.dart';
import 'package:sunnly/domain/usecases/get_locations.dart';
import 'package:sunnly/domain/usecases/get_weather.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  // Hive
  await Hive.initFlutter("SunnlyLocalDatabases");

  Hive.registerAdapter(LocationModelAdapter());
  Hive.registerAdapter(WeatherModelAdapter());

  final locationBox = await Hive.openBox<LocationModel>("locations");
  final weatherBox = await Hive.openBox<WeatherModel>("weathers");

  // Repositories
  final locactionRemoteDatasource = LocationRemoteDataSource();
  final locationLocalDatasource = LocationLocalDataSource(locationBox);

  final weatherRemoteDatasource = WeatherRemoteDataSource();
  final weatherLocalDatasource = WeatherLocalDataSource(weatherBox);

  final weatherRepo =
      IWeatherRepository(weatherRemoteDatasource, weatherLocalDatasource);
  final locationRepo =
      ILocationRepository(locactionRemoteDatasource, locationLocalDatasource);

  // Use cases
  final getLocations = GetLocations(locationRepo);
  final getWeather = GetWeather(weatherRepo);

  // Dependency injection
  final getIt = GetIt.instance;

  getIt.registerSingleton(const Uuid());
  getIt.registerSingleton(getLocations);
  getIt.registerSingleton(getWeather);
}
