// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleStatusImpl _$$VehicleStatusImplFromJson(Map<String, dynamic> json) =>
    _$VehicleStatusImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      vehicleId: json['vehicleId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$VehicleStatusImplToJson(_$VehicleStatusImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'vehicleId': instance.vehicleId,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': instance.status,
    };
