import 'package:cardinal/core/use_case/use_case.dart';
import 'package:cardinal/features/map/domain/use_cases/start_tracking.dart';
import 'package:cardinal/features/map/presentation/bloc/tracking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/stop_tracking.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final StartTrackingUseCase startTrackingUseCase;
  final StopTrackingUseCase stopTrackingUseCase;

  TrackingCubit(this.startTrackingUseCase, this.stopTrackingUseCase)
    : super(TrackingStopped());

  Future<void> start() async {
    await startTrackingUseCase(const NoParams());
    emit(TrackingRunning());
  }

  Future<void> stop() async {
    await stopTrackingUseCase(const NoParams());
    emit(TrackingStopped());
  }
}
