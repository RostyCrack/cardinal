import 'package:cardinal/features/emergency/data/models/vehicle_status_model.dart';
import 'package:cardinal/features/emergency/domain/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';

abstract class VehicleStatusRepository {
  Future<Either<VehicleStatusFailure, Unit>> saveVehicleStatus(VehicleStatusModel model);
}