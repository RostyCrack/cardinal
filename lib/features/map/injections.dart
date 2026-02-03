import 'dart:io';

import 'package:cardinal/features/map/data/datasource/ios_location_datasource.dart';
import 'package:cardinal/features/map/data/datasource/location_datasource.dart';
import 'package:cardinal/features/map/presentation/bloc/map_cubit.dart';
import 'package:cardinal/features/map/presentation/bloc/tracking_cubit.dart';

import '../../injections.dart';
import 'data/datasource/android_location_datasource.dart';
import 'data/repositories/tracking_repository.dart';
import 'domain/entities/location_entity.dart';
import 'domain/repositories/tracking_repository.dart';
import 'domain/use_cases/start_tracking.dart';
import 'domain/use_cases/stop_tracking.dart';

Future<void> initMapInjections()async {

// ==========================
  // DATA SOURCES
  // ==========================

  sl.registerLazySingleton<LocationDatasource>(() {
    if (Platform.isAndroid) {
      return AndroidLocationDatasource();
    } else if (Platform.isIOS) {
      return IosLocationDatasource();
    } else {
      throw UnsupportedError('Platform not supported');
    }
  });

  // ==========================
  // REPOSITORIES
  // ==========================

  sl.registerLazySingleton<TrackingRepository>(
        () => TrackingRepositoryImpl(
      datasource: sl<LocationDatasource>(),
    ),
  );

  // ==========================
  // USE CASES
  // ==========================

  sl.registerLazySingleton(
        () => StartTrackingUseCase(sl()),
  );

  sl.registerLazySingleton(
        () => StopTrackingUseCase(sl()),
  );

  // ==========================
  // STREAMS
  // ==========================

  sl.registerLazySingleton<Stream<LocationEntity>>(
        () => sl<TrackingRepository>().locationStream(),
  );

  // ==========================
  // CUBITS
  // ==========================

  sl.registerFactory(
        () => TrackingCubit(
      startTracking: sl(),
      stopTracking: sl(),
      locationStream: sl(),
    ),
  );

  sl.registerFactory(
        () => MapCubit(),
  );
}