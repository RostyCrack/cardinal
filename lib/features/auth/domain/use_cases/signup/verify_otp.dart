import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:cardinal/features/auth/domain/params/verify_otp_params.dart';
import 'package:cardinal/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class VerifyOtp {
  final AuthRepository authRepository;

  const VerifyOtp({required this.authRepository});

  /// Links the phone credential to the current Firebase user (does not sign in).
  Future<Either<AuthFailure, Unit>> call({required VerifyOtpParams params}) =>
      authRepository.linkPhoneCredential(
        params.verificationId,
        params.otpCode.value,
      );
}
