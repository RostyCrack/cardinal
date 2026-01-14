class TrackingRepositoryImpl implements TrackingRepository {
  final LocationDatasource datasource;

  TrackingRepositoryImpl(this.datasource);

  @override
  Future<Either<TrackingFailure, Unit>> startTracking() async {
    try {
      await datasource.start();
      return right(unit);
    } catch (e) {
      return left(TrackingFailure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<TrackingFailure, Unit>> stopTracking() async {
    try {
      await datasource.stop();
      return right(unit);
    } catch (e) {
      return left(TrackingFailure.unexpected(e.toString()));
    }
  }

  @override
  Stream<LocationEntity> locationStream() {
    return datasource.stream();
  }
}