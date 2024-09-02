import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunnly/data/datasources/location_remote_data_source.dart';
import 'package:sunnly/data/datasources/weather_remote_data_source.dart';
import 'package:sunnly/data/models/location_model.dart';
import 'package:sunnly/data/models/weather_model.dart';
import 'package:sunnly/data/repositories/location_repository_impl.dart';
import 'package:sunnly/data/repositories/weather_repository_impl.dart';
import 'package:sunnly/domain/usecases/get_location.dart';
import 'package:sunnly/domain/usecases/get_weather.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  // Hive
  await Hive.initFlutter("sunnly");

  Hive.registerAdapter(LocationModelAdapter());
  Hive.registerAdapter(WeatherModelAdapter());

  final locBox = await Hive.openBox("locations");
  final weaBox = await Hive.openBox("weathers");

  // Repositories
  final locRemoteDs = LocationRemoteDataSource();
  final weaRemoteDs = WeatherRemoteDataSource();

  final weatherRepo = IWeatherRepository(weaRemoteDs);
  final locRepo = ILocationRepository(locRemoteDs);

  // Use cases
  final getLocation = GetLocation(locRepo);
  final getWeather = GetWeather(weatherRepo);

  // Dependency injection
  final getIt = GetIt.instance;

  getIt.registerSingleton(const Uuid());
  getIt.registerSingleton(getLocation);
  getIt.registerSingleton(getWeather);
}
