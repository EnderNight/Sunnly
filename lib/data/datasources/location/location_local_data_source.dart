import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunnly/data/models/location_model.dart';

class LocationLocalDataSource {
  final Box<LocationModel> locationBox;

  const LocationLocalDataSource(this.locationBox);

  Future<List<LocationModel>> getLocations() async {
    return locationBox.values.toList();
  }

  Future<int> getLocationsAmount() async {
    return locationBox.length;
  }

  Future<void> addLocation(LocationModel loc) async {
    await locationBox.put(loc.id, loc);
  }

  Future<void> deleteLocation(LocationModel loc) async {
    await locationBox.delete(loc.id);
  }
}
