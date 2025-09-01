// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VehicleStatus _$VehicleStatusFromJson(Map<String, dynamic> json) {
  return _VehicleStatus.fromJson(json);
}

/// @nodoc
mixin _$VehicleStatus {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get vehicleId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this VehicleStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehicleStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleStatusCopyWith<VehicleStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleStatusCopyWith<$Res> {
  factory $VehicleStatusCopyWith(
    VehicleStatus value,
    $Res Function(VehicleStatus) then,
  ) = _$VehicleStatusCopyWithImpl<$Res, VehicleStatus>;
  @useResult
  $Res call({
    double latitude,
    double longitude,
    String vehicleId,
    DateTime timestamp,
    String status,
  });
}

/// @nodoc
class _$VehicleStatusCopyWithImpl<$Res, $Val extends VehicleStatus>
    implements $VehicleStatusCopyWith<$Res> {
  _$VehicleStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehicleStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? vehicleId = null,
    Object? timestamp = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            vehicleId: null == vehicleId
                ? _value.vehicleId
                : vehicleId // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VehicleStatusImplCopyWith<$Res>
    implements $VehicleStatusCopyWith<$Res> {
  factory _$$VehicleStatusImplCopyWith(
    _$VehicleStatusImpl value,
    $Res Function(_$VehicleStatusImpl) then,
  ) = __$$VehicleStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double latitude,
    double longitude,
    String vehicleId,
    DateTime timestamp,
    String status,
  });
}

/// @nodoc
class __$$VehicleStatusImplCopyWithImpl<$Res>
    extends _$VehicleStatusCopyWithImpl<$Res, _$VehicleStatusImpl>
    implements _$$VehicleStatusImplCopyWith<$Res> {
  __$$VehicleStatusImplCopyWithImpl(
    _$VehicleStatusImpl _value,
    $Res Function(_$VehicleStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VehicleStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? vehicleId = null,
    Object? timestamp = null,
    Object? status = null,
  }) {
    return _then(
      _$VehicleStatusImpl(
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        vehicleId: null == vehicleId
            ? _value.vehicleId
            : vehicleId // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VehicleStatusImpl implements _VehicleStatus {
  const _$VehicleStatusImpl({
    required this.latitude,
    required this.longitude,
    required this.vehicleId,
    required this.timestamp,
    required this.status,
  });

  factory _$VehicleStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleStatusImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String vehicleId;
  @override
  final DateTime timestamp;
  @override
  final String status;

  @override
  String toString() {
    return 'VehicleStatus(latitude: $latitude, longitude: $longitude, vehicleId: $vehicleId, timestamp: $timestamp, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleStatusImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    latitude,
    longitude,
    vehicleId,
    timestamp,
    status,
  );

  /// Create a copy of VehicleStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleStatusImplCopyWith<_$VehicleStatusImpl> get copyWith =>
      __$$VehicleStatusImplCopyWithImpl<_$VehicleStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleStatusImplToJson(this);
  }
}

abstract class _VehicleStatus implements VehicleStatus {
  const factory _VehicleStatus({
    required final double latitude,
    required final double longitude,
    required final String vehicleId,
    required final DateTime timestamp,
    required final String status,
  }) = _$VehicleStatusImpl;

  factory _VehicleStatus.fromJson(Map<String, dynamic> json) =
      _$VehicleStatusImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get vehicleId;
  @override
  DateTime get timestamp;
  @override
  String get status;

  /// Create a copy of VehicleStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleStatusImplCopyWith<_$VehicleStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
