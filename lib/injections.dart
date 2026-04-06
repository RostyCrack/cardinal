import 'package:cardinal/core/database/app_database.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/injections.dart';
import 'features/emergency/injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  _initDatabase();
  await initAuthInjections();
  await initEmergencyInjections();
}

void _initDatabase() {
  sl.registerSingleton<AppDatabase>(AppDatabase());
}
