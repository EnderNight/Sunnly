import 'package:sunnly/domain/entities/location.dart';

abstract class LocationRepository {
  Future<List<Location>> getLocations(String name);
}
