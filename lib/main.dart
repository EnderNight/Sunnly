import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunnly/data/models/location_model.dart';
import 'package:sunnly/data/models/weather_model.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  await Hive.initFlutter("sunnly");

  Hive.registerAdapter(LocationModelAdapter());
  Hive.registerAdapter(WeatherModelAdapter());

  final getIt = GetIt.instance;

  getIt.registerSingleton(const Uuid());
}
