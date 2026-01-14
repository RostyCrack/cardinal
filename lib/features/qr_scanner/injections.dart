import 'package:cardinal/features/qr_scanner/data/data_sources/qr_remote_data_source.dart';
import 'package:cardinal/features/qr_scanner/domain/repositories/qr_repository.dart';
import 'package:cardinal/features/qr_scanner/domain/use_cases/send_document_use_case.dart';
import 'package:cardinal/features/qr_scanner/presentation/bloc/qr_reader_cubit.dart';

import '../../core/helper/auth_manager.dart';
import '../../core/helper/ws_login_helper.dart';
import '../../injections.dart';
import 'data/repositories/qr_repository_impl.dart';

Future<void> initQrInjections() async {
  ///helper
  sl.registerLazySingleton<WSLoginHelper>(() => WSLoginHelper(sl()));

  sl.registerLazySingleton<AuthManager>(() => AuthManager(
    wsService: sl<WSLoginHelper>(),
  ));


  ///Cubits
  sl.registerFactory(
    () => QrReaderCubit(sendDocumentUseCase: sl<SendDocumentUseCase>()),
  );

  ///Data Sources
  sl.registerSingleton<QrRemoteDataSource>(QrRemoteDataSource(sl()));

  ///Repositories
  sl.registerSingleton<QrRepository>(
    QrRepositoryImpl(sl<QrRemoteDataSource>(), sl()),
  );

  ///Use Cases
  sl.registerSingleton<SendDocumentUseCase>(
    SendDocumentUseCase(sl<QrRepository>()),
  );
}
