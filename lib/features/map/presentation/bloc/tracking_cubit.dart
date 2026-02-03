import 'dart:async';

import 'package:cardinal/features/map/domain/use_cases/start_tracking.dart';
import 'package:cardinal/features/map/domain/use_cases/stop_tracking.dart';
import 'package:cardinal/features/map/presentation/bloc/tracking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/use_case/use_case.dart';
import '../../domain/entities/location_entity.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final StartTrackingUseCase startTracking;
  final StopTrackingUseCase stopTracking;
  final Stream<LocationEntity> locationStream;

  StreamSubscription<LocationEntity>? _sub;

  TrackingCubit({
    required this.startTracking,
    required this.stopTracking,
    required this.locationStream,
  }) : super(TrackingInitial());

  Future<void> start() async {
    final result = await startTracking(const NoParams());

    result.fold(
          (failure) => emit(TrackingError(failure)),
          (_) {
        emit(TrackingRunning());
        _sub = locationStream.listen(_onLocation);
      },
    );
  }

  void _onLocation(LocationEntity location) {
    emit(TrackingLocationUpdated(location));
  }

  Future<void> stop() async {
    await _sub?.cancel();
    await stopTracking(const NoParams());
    emit(TrackingStopped());
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}