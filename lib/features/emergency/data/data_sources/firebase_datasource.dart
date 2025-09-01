import 'dart:developer';

import 'package:cardinal/core/constants/constantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vehicle_status_model.dart';

abstract class VehicleStatusRemoteDataSource {
  Future<void> saveVehicleStatus(VehicleStatusModel model);
}

class VehicleStatusRemoteDataSourceImpl implements VehicleStatusRemoteDataSource {
  final FirebaseFirestore firestore;

  VehicleStatusRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> saveVehicleStatus(VehicleStatusModel model) async {
    log("VehicleStatusRemoteDataSourceImpl/saveVehicleStatus: called with model: ${model.toString()}");
    await firestore
        .collection(VEHICLE_STATUS_COLLECTION)
        .doc(model.vehicleId) // aquí defines el ID
        .set(model.toMap());
  }
}