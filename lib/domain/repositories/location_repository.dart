import 'package:sunnly/domain/entities/location.dart';

abstract class LocationRepository {
  Future<Location> getLocation(double lat, double lon);
}
