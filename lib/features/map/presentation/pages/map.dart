import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/map_cubit.dart';
import '../bloc/map_state.dart';

class MapScreen extends StatelessWidget {
  final String title;
  final CameraPosition? initialCamera;

  const MapScreen({
    super.key,
    this.title = 'Mapa',
    this.initialCamera,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapCubit(initialCamera: initialCamera),
      child: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: state.camera,
                  markers: state.markers,
                  myLocationEnabled: state.hasLocationPermission,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: context.read<MapCubit>().onMapCreated,
                ),
                if (state.loading)
                  const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(minHeight: 3),
                  ),
                if (state.error != null)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: _ErrorBanner(state.error!),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
