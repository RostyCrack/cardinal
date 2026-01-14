import 'package:dartz/dartz.dart';

import '../../../../core/use_case/use_case.dart';
import '../exceptions/tracking_failure.dart';
import '../repositories/tracking_repository.dart';

class StopTrackingUseCase extends UseCase<Unit, NoParams, TrackingFailure> {
  final TrackingRepository repository;

  StopTrackingUseCase(this.repository);

  @override
  Future<Either<TrackingFailure, Unit>> call(NoParams params) => repository.stopTracking();
}