import 'package:sunnly/data/datasources/location/location_local_data_source.dart';
import 'package:sunnly/data/datasources/location/location_remote_data_source.dart';
import 'package:sunnly/domain/entities/location.dart';
import 'package:sunnly/domain/repositories/location_repository.dart';

class ILocationRepository implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;
  final LocationLocalDataSource localDataSource;

  ILocationRepository(
    this.remoteDataSource,
    this.localDataSource,
  );

  Future<void> _cleanLocations() async {
    final locations = await localDataSource.getLocations();
    final now = DateTime.now();

    for (final loc in locations) {
      if (now.difference(loc.delta).inDays >= 7) {
        await localDataSource.deleteLocation(loc);
      }
    }
  }

  @override
  Future<List<Location>> getLocations(String name) async {
    final now = DateTime.now();

    final locations = (await localDataSource.getLocations()).where((loc) =>
        loc.requestName == name && now.difference(loc.delta).inDays < 7);

    if (locations.isNotEmpty) {
      return locations.map((loc) => loc.toEntity()).toList();
    }

    final models = await remoteDataSource.getLocations(name);

    for (final model in models) {
      await localDataSource.addLocation(model);
    }

    _cleanLocations();

    return models.map((model) => model.toEntity()).toList();
  }
}
