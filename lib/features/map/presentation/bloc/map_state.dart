import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool loading;
  final CameraPosition camera;
  final Set<Marker> markers;
  final String? error;

  const MapState({
    required this.loading,
    required this.camera,
    this.markers = const {},
    this.error,
  });

  MapState copyWith({
    bool? loading,
    CameraPosition? camera,
    Set<Marker>? markers,
    String? error,
  }) {
    return MapState(
      loading: loading ?? this.loading,
      camera: camera ?? this.camera,
      markers: markers ?? this.markers,
      error: error,
    );
  }
}

