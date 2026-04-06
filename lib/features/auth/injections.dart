import 'package:cardinal/features/auth/data/data_sources/sso/sso_api_client.dart';
import 'package:cardinal/features/auth/data/data_sources/sso/sso_data_source.dart';
import 'package:cardinal/features/auth/data/repositories/sso_repository_impl.dart';
import 'package:cardinal/features/auth/data/session/signup_flow_session_impl.dart';
import 'package:cardinal/features/auth/domain/ports/signup_flow_session.dart';
import 'package:cardinal/features/auth/domain/repositories/auth_repository.dart';
import 'package:cardinal/features/auth/domain/repositories/sso_repository.dart';
import 'package:cardinal/features/auth/domain/use_cases/auth/login_and_register_sso_use_case.dart';
import 'package:cardinal/features/auth/domain/use_cases/confirm_sms_use_case.dart';
import 'package:cardinal/features/auth/domain/use_cases/listen_auth_state.dart';
import 'package:cardinal/features/auth/domain/use_cases/logout.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/complete_signup_after_otp_use_case.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/send_otp.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/sign_up.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/start_signup_flow_use_case.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/verify_otp.dart';
import 'package:cardinal/features/auth/domain/use_cases/sso/get_fcm_token.dart';
import 'package:cardinal/features/auth/domain/use_cases/sso/get_id_token.dart';
import 'package:cardinal/features/auth/domain/use_cases/sso/register_user_sso.dart';
import 'package:cardinal/features/auth/domain/use_cases/verify_phone_use_case.dart';
import 'package:cardinal/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:cardinal/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:cardinal/features/auth/presentation/cubit/sso_login_cubit.dart';
import 'package:cardinal/features/auth/presentation/pages/verify_sms_screen.dart';
import 'package:cardinal/core/database/app_database.dart';
import 'package:dio/dio.dart';
import '../../injections.dart';
import 'data/data_sources/firebase_data_source.dart';
import 'data/data_sources/user_local_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/use_cases/login.dart';
import 'domain/use_cases/save_user_locally.dart';
import 'domain/use_cases/sign_up_use_case.dart';

Future<void> initAuthInjections() async {

  ///Data Sources
  sl.registerSingleton<FirebaseAuthDataSource>(
    FirebaseAuthDataSourceImpl(),
  );

  sl.registerSingleton<UserLocalDataSource>(
    UserLocalDataSourceImpl(sl<AppDatabase>()),
  );

  final ssoDio = Dio();
  sl.registerSingleton<SsoApiClient>(SsoApiClientImpl(ssoDio));
  sl.registerSingleton<SsoDataSource>(
    SsoDataSourceImpl(client: sl<SsoApiClient>()),
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
  sl.registerSingleton<SsoRepository>(
    SsoRepositoryImpl(ssoDataSource: sl<SsoDataSource>()),
  );

  ///Session
  sl.registerSingleton<SignUpFlowSession>(SignUpFlowSessionImpl());

  ///Use Cases — core
  sl.registerSingleton<ListenAuthStateUseCase>(ListenAuthStateUseCase(sl<AuthRepository>()));
  sl.registerSingleton<SaveUserLocallyUseCase>(SaveUserLocallyUseCase(sl<UserRepository>()));
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl<AuthRepository>(), sl<UserRepository>()));
  sl.registerLazySingleton<ConfirmSmsCodeUseCase>(() => ConfirmSmsCodeUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(() => VerifyPhoneNumberUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(authRepository: sl<AuthRepository>()));
  sl.registerSingleton<LoginUseCase>(
    LoginUseCase(authRepository: sl<AuthRepository>(), saveUserLocally: sl<SaveUserLocallyUseCase>()),
  );

  ///Use Cases — SSO
  sl.registerLazySingleton<GetIdToken>(() => GetIdToken());
  sl.registerLazySingleton<GetFcmToken>(() => GetFcmToken());
  sl.registerLazySingleton<RegisterUserSso>(
    () => RegisterUserSso(ssoRepository: sl<SsoRepository>()),
  );
  sl.registerLazySingleton<SendOtp>(
    () => SendOtp(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<VerifyOtp>(
    () => VerifyOtp(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignUp>(
    () => SignUp(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LoginAndRegisterSsoUseCase>(
    () => LoginAndRegisterSsoUseCase(
      authRepository: sl<AuthRepository>(),
      registerUserSsoUseCase: sl<RegisterUserSso>(),
      getIdTokenUseCase: sl<GetIdToken>(),
      getFcmTokenUseCase: sl<GetFcmToken>(),
    ),
  );
  sl.registerLazySingleton<StartSignUpFlowUseCase>(
    () => StartSignUpFlowUseCase(
      sendOtpUseCase: sl<SendOtp>(),
      session: sl<SignUpFlowSession>(),
    ),
  );
  sl.registerLazySingleton<CompleteSignUpAfterOtpUseCase>(
    () => CompleteSignUpAfterOtpUseCase(
      signUpUseCase: sl<SignUp>(),
      verifyOtpUseCase: sl<VerifyOtp>(),
      getIdTokenUseCase: sl<GetIdToken>(),
      getFcmTokenUseCase: sl<GetFcmToken>(),
      registerUserSsoUseCase: sl<RegisterUserSso>(),
      session: sl<SignUpFlowSession>(),
    ),
  );

  ///Bloc
  sl.registerFactory(() => AuthCubit(
      listenAuthState: sl<ListenAuthStateUseCase>(),
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
  ));

  sl.registerFactory(() => SignUpCubit(
      signUpUseCase: sl<SignUpUseCase>(),
      saveUserLocallyUseCase: sl<SaveUserLocallyUseCase>(),
      verifyPhoneNumberUseCase: sl<VerifyPhoneNumberUseCase>(),
      confirmSmsCodeUseCase: sl<ConfirmSmsCodeUseCase>(),
  ));

  sl.registerFactory(() => SsoLoginCubit(
      loginAndRegisterSsoUseCase: sl<LoginAndRegisterSsoUseCase>(),
  ));
}
