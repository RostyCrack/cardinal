import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/send_otp.dart';

abstract class StartSignUpResult {}

class StartSignUpOtpSent extends StartSignUpResult {
  final OtpSentResponse otpResponse;
  StartSignUpOtpSent(this.otpResponse);
}

class StartSignUpFailure extends StartSignUpResult {
  final AuthFailure failure;
  StartSignUpFailure(this.failure);
}
