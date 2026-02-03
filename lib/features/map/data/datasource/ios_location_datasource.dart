import 'dart:async';

import 'package:geolocator/geolocator.dart';

import '../../domain/entities/location_entity.dart';
import 'location_datasource.dart';

class IosLocationDatasource implements LocationDatasource {
  StreamController<LocationEntity>? _controller;

  @override
  Future<void> start() async {
    _controller = StreamController();

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 10,
      ),
    ).listen((pos) {
      _controller!.add(
        LocationEntity(
          latitude: pos.latitude,
          longitude: pos.longitude,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  @override
  Stream<LocationEntity> stream() => _controller!.stream;

  @override
  Future<void> stop() async {
    await _controller?.close();
  }
}