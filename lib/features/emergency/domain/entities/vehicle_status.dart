import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_status.freezed.dart';
part 'vehicle_status.g.dart';

@freezed
class VehicleStatus with _$VehicleStatus {
  const factory VehicleStatus({
    required double latitude,
    required double longitude,
    required String vehicleId,
    required DateTime timestamp,
    required String status,
  }) = _VehicleStatus;

  factory VehicleStatus.fromJson(Map<String, dynamic> json) =>
      _$VehicleStatusFromJson(json);
}