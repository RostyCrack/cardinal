import 'dart:ui';
import 'package:cardinal/features/map/presentation/bloc/tracking_cubit.dart';
import 'package:cardinal/features/map/presentation/bloc/tracking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  GoogleMapController? _controller;

  MapCubit({CameraPosition? initialCamera})
      : super(
    MapState(
      loading: true,
      camera: initialCamera ??
          const CameraPosition(
            target: LatLng(4.710989, -74.072090), // Bogotá
            zoom: 12,
          ), hasLocationPermission: false,
    ),
  ) {
    _init();
  }

  Future<void> _init() async {
    // Solicita permiso de ubicación
    final status = await Permission.locationWhenInUse.request();
    if (status.isPermanentlyDenied) {
      emit(state.copyWith(
        loading: false,
        error: 'Permiso denegado permanentemente',
      ));
      return;
    }

    // Marcador demo
    final demoMarkers = <Marker>{
      const Marker(
        markerId: MarkerId('center'),
        position: LatLng(4.710989, -74.072090),
        infoWindow: InfoWindow(title: 'Bogotá'),
      ),
    };

    emit(state.copyWith(loading: false, markers: demoMarkers));
  }

  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  Future<void> animateTo(LatLng target, {double zoom = 14}) async {
    final c = _controller;
    if (c == null) return;
    await c.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: zoom),
      ),
    );
  }

  void listenToTracking(TrackingCubit trackingCubit) {
    trackingCubit.stream.listen((state) {
      if (state is TrackingLocationUpdated) {
        updateUserMarker(LatLng(state.location.latitude, state.location.longitude));
    }}
    );
  }

  void updateUserMarker(LatLng position) {
    final userMarker = Marker(
      markerId: const MarkerId('user'),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueAzure,
      ),
      anchor: const Offset(0.5, 0.5),
    );

    final updatedMarkers = Set<Marker>.from(state.markers)
      ..removeWhere((m) => m.markerId.value == 'user')
      ..add(userMarker);

    emit(
      state.copyWith(
        markers: updatedMarkers,
      ),
    );
  }
}