import 'package:cardinal/features/map/domain/exceptions/tracking_failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/location_entity.dart';

abstract class TrackingRepository {
  Future<Either<TrackingFailure, Unit>> startTracking();
  Future<Either<TrackingFailure, Unit>>  stopTracking();
  Stream<LocationEntity> locationStream();
}