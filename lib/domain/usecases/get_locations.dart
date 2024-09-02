import 'package:sunnly/domain/entities/location.dart';
import 'package:sunnly/domain/repositories/location_repository.dart';

class GetLocations {
  final LocationRepository repository;

  const GetLocations(this.repository);

  Future<List<Location>> call(String name) async {
    return await repository.getLocations(name);
  }
}
