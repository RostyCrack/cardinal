import 'package:cardinal/core/constants/sso/sso_constants.dart';
import 'package:cardinal/features/auth/data/results/complete_signup_result.dart';
import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:cardinal/features/auth/domain/failures/auth_failures.dart';
import 'package:cardinal/features/auth/domain/params/register_sso_params.dart';
import 'package:cardinal/features/auth/domain/params/sign_up_firebase_params.dart';
import 'package:cardinal/features/auth/domain/params/verify_otp_params.dart';
import 'package:cardinal/features/auth/domain/ports/signup_flow_session.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/sign_up.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/verify_otp.dart';
import 'package:cardinal/features/auth/domain/use_cases/sso/get_fcm_token.dart';
import 'package:cardinal/features/auth/domain/use_cases/sso/get_id_token.dart';
import 'package:cardinal/features/auth/domain/use_cases/sso/register_user_sso.dart';
import 'package:cardinal/features/auth/domain/value_objects/auth_vos.dart';
import 'package:cardinal/features/auth/data/exceptions/singup_exceptions.dart';

class CompleteSignUpAfterOtpUseCase {
  final SignUp signUpUseCase;
  final VerifyOtp verifyOtpUseCase;
  final GetIdToken getIdTokenUseCase;
  final GetFcmToken getFcmTokenUseCase;
  final RegisterUserSso registerUserSsoUseCase;
  final SignUpFlowSession session;

  const CompleteSignUpAfterOtpUseCase({
    required this.signUpUseCase,
    required this.verifyOtpUseCase,
    required this.getIdTokenUseCase,
    required this.getFcmTokenUseCase,
    required this.registerUserSsoUseCase,
    required this.session,
  });

  Future<CompleteSignUpResult> call({
    required String otp,
    bool skipPhoneVerification = false,
  }) async {
    final pending = session.pendingSignUp;
    if (pending == null) return const CompleteSignUpNoPending();

    final pk = session.validatedProductKey;
    if (pk == null) return const CompleteSignUpProductKeyNotValidated();

    // 1) Create Firebase account (email/password) to get an authenticated session
    final signUpRes = await signUpUseCase(
      params: SignUpFirebaseParams(
        emailAddress: pending.email,
        password: pending.password,
        name: pending.name,
      ),
    );
    if (signUpRes.isLeft()) {
      return CompleteSignUpFailure(
        signUpRes.swap().getOrElse(() => const UnknownAuthFailure(null)),
      );
    }
    final firebaseUser = signUpRes.getOrElse(() => throw StateError('unreachable'));
    final firebaseUid = firebaseUser.uid;

    // 2) Link phone OTP to the newly created Firebase account
    if (!skipPhoneVerification) {
      final verificationId = session.validationId;
      if (verificationId == null) {
        return const CompleteSignUpFailure(
          UnknownAuthFailure('Missing validation id in session'),
        );
      }

      final verifyRes = await verifyOtpUseCase.call(
        params: VerifyOtpParams(
          verificationId: verificationId,
          otpCode: OtpCode(otp),
        ),
      );
      if (verifyRes.isLeft()) {
        final failure = verifyRes.swap().getOrElse(() => const UnknownAuthFailure(null));
        if (failure is FirebaseCredentialAlreadyInUseFailure) {
          return const CompleteSignUpPhoneAlreadyInUse();
        }
        return CompleteSignUpOtpFailure(failure);
      }
    }

    // 3) Get idToken
    final idTokenRes = await getIdTokenUseCase();
    if (idTokenRes.isLeft()) {
      return CompleteSignUpFailure(
        idTokenRes.swap().getOrElse(() => const UnknownAuthFailure(null)),
      );
    }
    final idToken = idTokenRes.getOrElse(() => const IdToken(''));

    // 4) Get FCM token (failure is non-blocking — fall back to empty string)
    final fcmRes = await getFcmTokenUseCase();
    final tokenFcm = fcmRes.getOrElse(() => '');

    // 5) Register SSO
    final registerRes = await registerUserSsoUseCase(
      RegisterSsoParams(
        idToken: idToken,
        productKey: pk,
        firebaseUid: FirebaseUid(firebaseUid),
        phoneNumber: pending.phone,
        fullName: pending.name,
        email: pending.email,
        tokenFcm: tokenFcm,
        systemCode: SSO_SYSTEM_CODE,
      ),
    );

    return registerRes.fold(
      (failure) => CompleteSignUpFailure(failure),
      (ssoSession) {
        session.clearAll();

        final user = UserEntity.fromFirebaseUidAndSso(
          uid: firebaseUid,
          ssoSession: ssoSession,
          email: pending.email.value,
          displayName: pending.name.value,
          photoUrl: pending.photoUrl,
          phoneNumber: pending.phone.value,
        );

        return CompleteSignUpSuccess(user);
      },
    );
  }
}
