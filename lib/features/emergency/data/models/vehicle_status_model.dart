import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/vehicle_status.dart';

class VehicleStatusModel {
  final double latitude;
  final double longitude;
  final String vehicleId;
  final DateTime timestamp;
  final String status;

  const VehicleStatusModel({
    required this.latitude,
    required this.longitude,
    required this.vehicleId,
    required this.timestamp,
    required this.status,
  });

  factory VehicleStatusModel.fromJson(Map<String, dynamic> json) => VehicleStatusModel(
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    vehicleId: json['vehicleId'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
    status: json['status'] as String,
  );

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'vehicleId': vehicleId,
    'timestamp': timestamp.toIso8601String(),
    'status': status,
  };

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

  factory VehicleStatusModel.fromEntity(VehicleStatus entity) => VehicleStatusModel(
    latitude: entity.latitude,
    longitude: entity.longitude,
    vehicleId: entity.vehicleId,
    timestamp: entity.timestamp,
    status: entity.status,
  );

  Map<String, dynamic> toMap() => {
    'location': GeoPoint(latitude, longitude),
    'vehicleId': vehicleId,
    'timestamp': Timestamp.fromDate(timestamp),
    'status': status,
  };

  VehicleStatus toEntity() => VehicleStatus(
    latitude: latitude,
    longitude: longitude,
    vehicleId: vehicleId,
    timestamp: timestamp,
    status: status,
  );

  VehicleStatusModel copyWith({
    double? latitude,
    double? longitude,
    String? vehicleId,
    DateTime? timestamp,
    String? status,
  }) => VehicleStatusModel(
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    vehicleId: vehicleId ?? this.vehicleId,
    timestamp: timestamp ?? this.timestamp,
    status: status ?? this.status,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleStatusModel &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          vehicleId == other.vehicleId &&
          timestamp == other.timestamp &&
          status == other.status;

  @override
  int get hashCode => Object.hash(latitude, longitude, vehicleId, timestamp, status);

  @override
  String toString() =>
      'VehicleStatusModel(latitude: $latitude, longitude: $longitude, vehicleId: $vehicleId, timestamp: $timestamp, status: $status)';
}