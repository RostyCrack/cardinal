import 'package:cardinal/features/emergency/domain/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../data/data_sources/firebase_datasource.dart';
import '../../data/models/vehicle_status_repository.dart';
import '../../data/models/vehicle_status_model.dart';

class VehicleStatusRepositoryImpl implements VehicleStatusRepository {
  final VehicleStatusRemoteDataSource remoteDataSource;

  VehicleStatusRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<VehicleStatusFailure, Unit>> saveVehicleStatus(VehicleStatusModel model) async {
    try {
      await remoteDataSource.saveVehicleStatus(model);
      return const Right(unit);
    } catch (e) {
      return Left(VehicleStatusNotSavedFailure());
    }
  }
}