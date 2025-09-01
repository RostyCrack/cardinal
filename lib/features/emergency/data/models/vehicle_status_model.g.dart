// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleStatusModelImpl _$$VehicleStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VehicleStatusModelImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      vehicleId: json['vehicleId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$VehicleStatusModelImplToJson(
        _$VehicleStatusModelImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'vehicleId': instance.vehicleId,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': instance.status,
    };
