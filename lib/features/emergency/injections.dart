import 'package:cardinal/features/emergency/data/data_sources/firebase_datasource.dart';
import 'package:cardinal/features/emergency/data/models/vehicle_status_repository.dart';
import 'package:cardinal/features/emergency/data/repositories/audio_repository.dart';
import 'package:cardinal/features/emergency/domain/repositories/audio_repository_impl.dart';
import 'package:cardinal/features/emergency/domain/use_cases/start_recording_use_case.dart';
import 'package:cardinal/features/emergency/domain/use_cases/upload_recording_use_case.dart';
import 'package:cardinal/features/emergency/presentation/cubit/emergency_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:record/record.dart';

import '../../injections.dart';
import 'domain/repositories/vehicle_status_repository_impl.dart';
import 'domain/use_cases/save_vehicle_status.dart';
import 'domain/use_cases/stop_recording_use_case.dart';

Future<void> initEmergencyInjections() async {
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerFactory(
    () => EmergencyCubit(
      sl<StartRecordingUseCase>(),
      sl<StopRecordingUseCase>(),
      sl<UploadRecordingUseCase>(),
      sl<SaveVehicleLocationUseCase>(),
    ),
  );

  sl.registerLazySingleton<VehicleStatusRemoteDataSource>(
    () => VehicleStatusRemoteDataSourceImpl(sl<FirebaseFirestore>()),
  );

  // Repository
  sl.registerLazySingleton<AudioRepository>(() => AudioRepositoryImpl());
  sl.registerLazySingleton<VehicleStatusRepository>(
    () => VehicleStatusRepositoryImpl(sl<VehicleStatusRemoteDataSource>()),
  );

  // UseCases
  sl.registerLazySingleton(() => StartRecordingUseCase(sl<AudioRepository>()));
  sl.registerLazySingleton(() => StopRecordingUseCase(sl<AudioRepository>()));
  sl.registerLazySingleton(() => UploadRecordingUseCase());
  sl.registerLazySingleton(
    () => SaveVehicleLocationUseCase(sl<VehicleStatusRepository>()),
  );

  // Cubit
}
