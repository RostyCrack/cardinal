import 'dart:developer';

import 'package:cardinal/core/constants/sso/sso_constants.dart';
import 'package:cardinal/features/auth/data/results/login_and_register_result.dart';
import 'package:cardinal/features/auth/data/exceptions/login_exceptions.dart';
import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:cardinal/features/auth/domain/failures/auth_failures.dart';
import 'package:cardinal/features/auth/domain/params/register_sso_params.dart';
import 'package:cardinal/features/auth/domain/repositories/auth_repository.dart';
import 'package:cardinal/features/auth/domain/use_cases/sso/get_fcm_token.dart';
import 'package:cardinal/features/auth/domain/use_cases/sso/get_id_token.dart';
import 'package:cardinal/features/auth/domain/use_cases/sso/register_user_sso.dart';
import 'package:cardinal/features/auth/domain/value_objects/auth_vos.dart';

class LoginAndRegisterSsoUseCase {
  final AuthRepository authRepository;
  final RegisterUserSso registerUserSsoUseCase;
  final GetIdToken getIdTokenUseCase;
  final GetFcmToken getFcmTokenUseCase;

  const LoginAndRegisterSsoUseCase({
    required this.authRepository,
    required this.registerUserSsoUseCase,
    required this.getIdTokenUseCase,
    required this.getFcmTokenUseCase,
  });

  Future<LoginAndRegisterResult> call({
    required String email,
    required String password,
    required ProductKey productKey,
  }) async {
    // 1. Firebase login
    final loginRes = await authRepository.signIn(email, password);
    if (loginRes.isLeft()) {
      final failure = loginRes.swap().getOrElse(() => const UnknownAuthFailure(null));
      if (failure is UserNotFoundFailure || failure is WrongPasswordFailure) {
        return LoginAndRegisterUserNotFound();
      }
      return LoginAndRegisterFailure(failure);
    }
    final firebaseUser = loginRes.getOrElse(() => throw StateError('unreachable'));

    // 2. Get idToken
    final idTokenRes = await getIdTokenUseCase();
    if (idTokenRes.isLeft()) {
      log('LoginAndRegisterSso: failed to get idToken');
      return LoginAndRegisterFailure(
        idTokenRes.swap().getOrElse(() => const UnknownAuthFailure(null)),
      );
    }
    final idToken = idTokenRes.getOrElse(() => const IdToken(''));

    // 3. Get FCM token (non-blocking — failure falls back to empty string)
    final fcmRes = await getFcmTokenUseCase();
    final tokenFcm = fcmRes.getOrElse(() => '');

    // 4. Register in SSO using the Firebase account info
    final registerRes = await registerUserSsoUseCase(
      RegisterSsoParams(
        idToken: idToken,
        productKey: productKey,
        firebaseUid: FirebaseUid(firebaseUser.id),
        fullName: Name(firebaseUser.displayName ?? 'Usuario'),
        email: EmailAddress(firebaseUser.email),
        tokenFcm: tokenFcm,
        systemCode: SSO_SYSTEM_CODE,
      ),
    );

    return registerRes.fold(
      (failure) => LoginAndRegisterFailure(failure),
      (ssoSession) => LoginAndRegisterSuccess(
        UserEntity.fromFirebaseUidAndSso(
          uid: firebaseUser.id,
          displayName: firebaseUser.displayName ?? '',
          email: firebaseUser.email,
          photoUrl: '',
          ssoSession: ssoSession,
        ),
      ),
    );
  }
}
