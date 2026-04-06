import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:cardinal/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class OtpSentResponse {
  final String verificationId;
  final int? resendToken;

  const OtpSentResponse({required this.verificationId, this.resendToken});
}

class SendOtp {
  final AuthRepository authRepository;

  const SendOtp({required this.authRepository});

  Future<Either<AuthFailure, OtpSentResponse>> call({
    required String phoneNumber,
  }) =>
      authRepository.sendOtp(phoneNumber);
}
