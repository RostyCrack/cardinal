import 'package:cardinal/features/navigation/presentation/bloc/navigation_cubit.dart';

import '../../injections.dart';

Future<void> initNavigationInjections() async {

  sl.registerFactory(() => NavigationCubit());
}