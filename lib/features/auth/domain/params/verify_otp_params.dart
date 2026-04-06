import 'package:cardinal/features/auth/domain/value_objects/auth_vos.dart';

class VerifyOtpParams {
  final String verificationId;
  final OtpCode otpCode;

  const VerifyOtpParams({
    required this.verificationId,
    required this.otpCode,
  });
}
