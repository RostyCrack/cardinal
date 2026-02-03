import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool loading;
  final CameraPosition camera;
  final Set<Marker> markers;
  final String? error;
  final bool hasLocationPermission;

  const MapState({
    required this.loading,
    required this.camera,
    this.markers = const {},
    this.error,
    required this.hasLocationPermission
  });

  MapState copyWith({
    bool? loading,
    CameraPosition? camera,
    Set<Marker>? markers,
    String? error,
    bool? hasLocationPermission
  }) {
    return MapState(
      loading: loading ?? this.loading,
      camera: camera ?? this.camera,
      markers: markers ?? this.markers,
      error: error ?? this.error,
      hasLocationPermission: hasLocationPermission ?? this.hasLocationPermission
    );
  }
}

