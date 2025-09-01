import 'package:cardinal/features/auth/data/models/user_model.dart';
import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'features/auth/injections.dart';
import 'features/emergency/injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initHive();
  await initAuthInjections();
  await initEmergencyInjections();

  // Add other feature injections as needed
}


Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  var userBox = await Hive.openBox<UserModel>('userBox');
  sl.registerLazySingleton<Box<UserModel>>(() => userBox);
}