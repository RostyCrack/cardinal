import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/vehicle_status.dart';

part 'vehicle_status_model.freezed.dart';
part 'vehicle_status_model.g.dart';

@freezed
class VehicleStatusModel with _$VehicleStatusModel {
  const factory VehicleStatusModel({
    required double latitude,
    required double longitude,
    required String vehicleId,
    required DateTime timestamp,
    required String status,
  }) = _VehicleStatusModel;

  /// fromJson para json_serializable
  factory VehicleStatusModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleStatusModelFromJson(json);

  /// fromMap para Firestore (GeoPoint + Timestamp)
  factory VehicleStatusModel.fromMap(Map<String, dynamic> map) {
    final geoPoint = map['location'] as GeoPoint;
    return VehicleStatusModel(
      latitude: geoPoint.latitude,
      longitude: geoPoint.longitude,
      vehicleId: map['vehicleId'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      status: map['status'] as String,
    );
  }

  /// fromEntity
  factory VehicleStatusModel.fromEntity(VehicleStatus entity) {
    return VehicleStatusModel(
      latitude: entity.latitude,
      longitude: entity.longitude,
      vehicleId: entity.vehicleId,
      timestamp: entity.timestamp,
      status: entity.status,
    );
  }
}

/// Métodos auxiliares fuera de la clase Freezed
extension VehicleStatusModelX on VehicleStatusModel {
  /// Convertir a Map de Firestore
  Map<String, dynamic> toMap() {
    return {
      'location': GeoPoint(latitude, longitude),
      'vehicleId': vehicleId,
      'timestamp': Timestamp.fromDate(timestamp),
      'status': status,
    };
  }

  /// Convertir a entidad
  VehicleStatus toEntity() {
    return VehicleStatus(
      latitude: latitude,
      longitude: longitude,
      vehicleId: vehicleId,
      timestamp: timestamp,
      status: status,
    );
  }
}