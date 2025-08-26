import 'package:cardinal/features/auth/domain/repositories/auth_repository.dart';
import 'package:cardinal/features/auth/domain/use_cases/listen_auth_state.dart';
import 'package:cardinal/features/auth/presentation/cubit/auth_cubit.dart';
import '../../injections.dart';
import 'data/data_sources/firebase_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/use_cases/login.dart';

Future<void> initAuthInjections() async {

  ///Data Sources
  /// Firebase Data Source
  sl.registerSingleton<FirebaseAuthDataSource>(
    FirebaseAuthDataSourceImpl(),
  );

  ///Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      firebaseAuthDataSource: sl<FirebaseAuthDataSource>(),
    ),
  );


  ///Use Cases
  sl.registerSingleton<ListenAuthStateUseCase>(ListenAuthStateUseCase(sl()));

  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));

  ///Bloc
  sl.registerFactory(() => AuthCubit(
      listenAuthState: sl(),
      loginUseCase: sl()
  ));


}
