import 'package:sunnly/domain/entities/location.dart';
import 'package:sunnly/domain/repositories/location_repository.dart';

class GetLocation {
  final LocationRepository repository;

  const GetLocation(this.repository);

  Future<List<Location>> call(String name) async {
    return await repository.getLocation(name);
  }
}
