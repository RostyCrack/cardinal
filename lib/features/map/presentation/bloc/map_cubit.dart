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
          ),
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
}