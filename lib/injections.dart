import 'package:get_it/get_it.dart';

import 'features/auth/injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  // Initialize all injections here
  await initAuthInjections();
  // Add other feature injections as needed
}