import 'package:cardinal/core/failure/failure.dart';



class AudioFailure extends Failure {
  const AudioFailure(super.message);
}
class NoActiveRecordingException extends AudioFailure {
  const NoActiveRecordingException() : super("No hay ninguna grabación activa.");
}

class NoPermissionException extends AudioFailure {
  const NoPermissionException() : super("No tienes permiso para grabar audio.");
}

class UnableToGetIsAudioRecordingException extends AudioFailure {
  const UnableToGetIsAudioRecordingException() : super("No se pudo obtener el estado de grabación de audio.");
}

class VehicleStatusFailure extends Failure {
  const VehicleStatusFailure(super.message);
}

class VehicleStatusNotSavedFailure extends VehicleStatusFailure {
  const VehicleStatusNotSavedFailure() : super("No se pudo guardar el estado del vehículo.");
}