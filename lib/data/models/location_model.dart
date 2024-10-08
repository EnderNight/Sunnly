import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sunnly/domain/entities/location.dart';
import 'package:uuid/uuid.dart';

part 'location_model.g.dart';

@HiveType(typeId: 2)
class LocationModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double lat;

  @HiveField(2)
  final double lon;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String country;

  @HiveField(5)
  final String? state;

  @HiveField(6)
  final DateTime delta;

  @HiveField(7)
  final String requestName;

  const LocationModel({
    required this.id,
    required this.delta,
    required this.lat,
    required this.lon,
    required this.name,
    required this.country,
    required this.state,
    required this.requestName,
  });

  Location toEntity() {
    return Location(
      id: id,
      delta: delta,
      lat: lat,
      lon: lon,
      name: name,
      country: country,
      state: state,
      requestName: requestName,
    );
  }

  factory LocationModel.fromEntity(Location location) {
    return LocationModel(
      id: location.id,
      delta: location.delta,
      lat: location.lat,
      lon: location.lon,
      name: location.name,
      requestName: location.requestName,
      country: location.country,
      state: location.state,
    );
  }

  factory LocationModel.fromJson(Map json, String requestName) {
    return LocationModel(
      id: GetIt.I.get<Uuid>().v4(),
      delta: DateTime.now(),
      lat: json["lat"],
      lon: json["lon"],
      name: json["name"],
      requestName: requestName,
      country: json["country"],
      state: json.containsKey("state") ? json["state"] : null,
    );
  }
}
