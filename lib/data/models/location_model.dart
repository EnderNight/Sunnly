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

  const LocationModel({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
  });

  Location toEntity() {
    return Location(
      id: id,
      lat: lat,
      lon: lon,
      name: name,
    );
  }

  factory LocationModel.fromEntity(Location location) {
    return LocationModel(
      id: location.id,
      lat: location.lat,
      lon: location.lon,
      name: location.name,
    );
  }

  factory LocationModel.fromJson(Map json) {
    return LocationModel(
      id: GetIt.I.get<Uuid>().v4(),
      lat: double.parse(json[0]["lat"]),
      lon: double.parse(json[0]["lon"]),
      name: json[0]["name"],
    );
  }
}
