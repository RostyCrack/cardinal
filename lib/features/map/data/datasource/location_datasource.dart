import '../../domain/entities/location_entity.dart';

abstract class LocationDatasource {
  Future<void> start();
  Future<void> stop();
  Stream<LocationEntity> stream();
}

