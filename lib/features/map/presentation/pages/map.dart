import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../injections.dart';
import '../bloc/map_cubit.dart';
import '../bloc/map_state.dart';
import '../bloc/tracking_cubit.dart';
import '../bloc/tracking_state.dart';

class MapScreen extends StatefulWidget {
  final String title;
  final CameraPosition? initialCamera;

  const MapScreen({
    super.key,
    this.title = 'Mapa',
    this.initialCamera,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapCubit>(
          create: (_) => MapCubit(initialCamera: widget.initialCamera),
        ),
        BlocProvider<TrackingCubit>(
          create: (_) => sl<TrackingCubit>()..start(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<TrackingCubit, TrackingState>(
            listener: (context, state) {
              if (state is TrackingLocationUpdated) {
                context.read<MapCubit>().updateUserMarker(LatLng(state.location.latitude, state.location.longitude));
              }
            },
          ),
        ],
        child: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
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
                    _ErrorBanner(message: state.error!),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback? onClose;

  const _ErrorBanner({
    required this.message,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        color: Colors.red.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (onClose != null)
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: onClose,
                ),
            ],
          ),
        ),
      ),
    );
  }
}