import 'package:cardinal/core/failure/failure.dart';
import 'package:cardinal/features/emergency/domain/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/vehicle_status_model.dart';
import '../../data/models/vehicle_status_repository.dart';
import '../entities/vehicle_status.dart';


class SaveVehicleLocationUseCase extends UseCase<Unit, String, VehicleStatusFailure> {
  final VehicleStatusRepository repository;

  SaveVehicleLocationUseCase(this.repository);


  @override
  Future<Either<VehicleStatusFailure, Unit>> call(String vehicleId) async {
    // Obtener ubicación
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Crear entity
    final entity = VehicleStatus(
      latitude: position.latitude,
      longitude: position.longitude,
      vehicleId: vehicleId,
      timestamp: DateTime.now(),
      status: 'active',
    );

    // Convertir a modelo
    final model = VehicleStatusModel.fromEntity(entity);


    return repository.saveVehicleStatus(model);
  }
}