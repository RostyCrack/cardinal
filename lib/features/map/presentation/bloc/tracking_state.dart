import '../../domain/entities/location_entity.dart';
import '../../domain/exceptions/tracking_failure.dart';

sealed class TrackingState {}

class TrackingInitial extends TrackingState {}

class TrackingRunning extends TrackingState {}

class TrackingStopped extends TrackingState {}

class TrackingLocationUpdated extends TrackingState {
  final LocationEntity location;
  TrackingLocationUpdated(this.location);
}

class TrackingError extends TrackingState {
  final TrackingFailure failure;
  TrackingError(this.failure);
}