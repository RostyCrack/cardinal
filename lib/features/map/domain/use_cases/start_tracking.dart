import 'package:cardinal/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

import '../exceptions/tracking_failure.dart';
import '../repositories/tracking_repository.dart';

class StartTrackingUseCase extends UseCase<Unit, NoParams, TrackingFailure>{
  final TrackingRepository repository;

  StartTrackingUseCase(this.repository);

  @override
  Future<Either<TrackingFailure, Unit>> call(NoParams params) => repository.startTracking();
}