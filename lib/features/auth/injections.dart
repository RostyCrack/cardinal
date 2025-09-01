import 'package:cardinal/features/auth/domain/repositories/auth_repository.dart';
import 'package:cardinal/features/auth/domain/use_cases/listen_auth_state.dart';
import 'package:cardinal/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hive/hive.dart';
import '../../injections.dart';
import 'data/data_sources/firebase_data_source.dart';
import 'data/data_sources/user_local_data_source.dart';
import 'data/models/user_model.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/use_cases/login.dart';
import 'domain/use_cases/save_user_locally.dart';

Future<void> initAuthInjections() async {

  ///Data Sources
  /// Firebase Data Source
  sl.registerSingleton<FirebaseAuthDataSource>(
    FirebaseAuthDataSourceImpl(),
  );

  sl.registerSingleton<UserLocalDataSource>(
    UserLocalDataSourceImpl(sl<Box<UserModel>>()),
  );

  ///Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      firebaseAuthDataSource: sl<FirebaseAuthDataSource>(),
    ),
  );
  sl.registerSingleton<UserRepository>(
    UserRepositoryImpl(
      userLocalDataSource: sl<UserLocalDataSource>(),
    ),
  );

  ///Use Cases
  sl.registerSingleton<ListenAuthStateUseCase>(ListenAuthStateUseCase(sl()));
  sl.registerSingleton<SaveUserLocallyUseCase>(SaveUserLocallyUseCase(sl<UserRepository>()));

  sl.registerSingleton<LoginUseCase>(LoginUseCase(authRepository: sl<AuthRepository>(),
      saveUserLocally: sl<SaveUserLocallyUseCase>()));

  ///Bloc
  sl.registerFactory(() => AuthCubit(
      listenAuthState: sl<ListenAuthStateUseCase>(),
      loginUseCase: sl<LoginUseCase>()
  ));


}
