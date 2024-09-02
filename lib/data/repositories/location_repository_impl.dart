import 'package:sunnly/data/datasources/location_remote_data_source.dart';
import 'package:sunnly/domain/entities/location.dart';
import 'package:sunnly/domain/repositories/location_repository.dart';

class ILocationRepository implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;

  const ILocationRepository(this.remoteDataSource);

  @override
  Future<List<Location>> getLocation(String name) async {
    final models = await remoteDataSource.getLocation(name);

    return models.map((model) => model.toEntity()).toList();
  }
}
