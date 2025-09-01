import 'dart:developer';

import 'package:cardinal/features/emergency/domain/use_cases/save_vehicle_status.dart';
import 'package:cardinal/features/emergency/domain/use_cases/start_recording_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/use_case/use_case.dart';
import '../../domain/use_cases/stop_recording_use_case.dart';
import '../../domain/use_cases/upload_recording_use_case.dart';
import 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  final StartRecordingUseCase startRecordingUseCase;
  final StopRecordingUseCase stopRecordingUseCase;
  final UploadRecordingUseCase uploadRecordingUseCase;
  final SaveVehicleLocationUseCase saveVehicleLocationUseCase;

  EmergencyCubit(
    this.startRecordingUseCase,
    this.stopRecordingUseCase,
    this.uploadRecordingUseCase,
    this.saveVehicleLocationUseCase,
  ) : super(const EmergencyState.initial());

  Future<void> startRecording() async {
    emit(const EmergencyState.loading());
    try {
      final startedResult = await startRecordingUseCase.call(NoParams());
      startedResult.fold(
        (failure) {
          // manejar el error
          emit(EmergencyState.failure(failure.message));
        },
        (_) {
          // éxito: se empezó a grabar
          emit(EmergencyState.recording());
        },
      );
    } on Exception catch (e) {
      log(
        "EmergencyCubit/startRecording failed with exception: ${e.toString()}",
      );
      emit(EmergencyState.failure("Error desconocido al iniciar la grabación"));
    }
  }

  Future<void> stopRecording() async {
    emit(const EmergencyState.uploading());

    try {
      final stoppedResult = await stopRecordingUseCase.call(NoParams());

      await stoppedResult.fold(
        (failure) async {
          emit(EmergencyState.failure(failure.message));
        },
        (_) async {

          emit(EmergencyState.uploadSuccess());
        },
      );
    } on Exception catch (e) {
      emit(
        EmergencyState.failure("Error desconocido al detener la grabación: $e"),
      );
    }
  }

  Future<void> saveVehicleLocation() async {
    try {
      final result = await saveVehicleLocationUseCase.call("123");
      result.fold(
        (failure) {
          log("EmergencyCubit/saveVehicleLocation failed: ${failure.message}");
        },
        (_) {
          log("EmergencyCubit/saveVehicleLocation success");
        },
      );
    } on Exception catch (e) {
      log("EmergencyCubit/saveVehicleLocation exception: $e");
    }
  }
}
