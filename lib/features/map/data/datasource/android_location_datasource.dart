import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../core/helper/background_service.dart';
import '../../domain/entities/location_entity.dart';
import 'location_datasource.dart';

class AndroidLocationDatasource implements LocationDatasource {
  @override
  Future<void> start() async {
    await initializeService();
  }

  @override
  Stream<LocationEntity> stream() {
    final service = FlutterBackgroundService();

    return service.on('update').map(
          (event) => LocationEntity(
        latitude: event?['lat'],
        longitude: event?['lng'],
        timestamp: DateTime.parse(event?['timestamp']),
      ),
    );
  }

  @override
  Future<void> stop() async {
    FlutterBackgroundService().invoke('stopService');
  }
}