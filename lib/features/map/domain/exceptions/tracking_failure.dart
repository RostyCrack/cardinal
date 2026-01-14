import 'package:cardinal/core/failure/failure.dart';

sealed class TrackingFailure extends Failure{
  const TrackingFailure(super.message);

  factory TrackingFailure.permissionDenied() = PermissionDenied;
  factory TrackingFailure.serviceUnavailable() = ServiceUnavailable;
  factory TrackingFailure.unexpected(String message) = UnexpectedFailure;
}

class PermissionDenied extends TrackingFailure {
  const PermissionDenied() : super("No tienes permiso para acceder a la ubicación.");
}

class ServiceUnavailable extends TrackingFailure {
  const ServiceUnavailable() : super("El servicio de ubicación no está disponible.");
}

class UnexpectedFailure extends TrackingFailure {
  const UnexpectedFailure(String message) : super(message);
}