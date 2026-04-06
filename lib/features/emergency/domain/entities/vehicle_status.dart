class VehicleStatus {
  final double latitude;
  final double longitude;
  final String vehicleId;
  final DateTime timestamp;
  final String status;

  const VehicleStatus({
    required this.latitude,
    required this.longitude,
    required this.vehicleId,
    required this.timestamp,
    required this.status,
  });

  factory VehicleStatus.fromJson(Map<String, dynamic> json) => VehicleStatus(
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

  VehicleStatus copyWith({
    double? latitude,
    double? longitude,
    String? vehicleId,
    DateTime? timestamp,
    String? status,
  }) => VehicleStatus(
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    vehicleId: vehicleId ?? this.vehicleId,
    timestamp: timestamp ?? this.timestamp,
    status: status ?? this.status,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleStatus &&
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
      'VehicleStatus(latitude: $latitude, longitude: $longitude, vehicleId: $vehicleId, timestamp: $timestamp, status: $status)';
}