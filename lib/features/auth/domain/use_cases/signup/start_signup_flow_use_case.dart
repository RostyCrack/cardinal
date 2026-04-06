import 'package:cardinal/features/auth/data/results/start_signup_result.dart';
import 'package:cardinal/features/auth/domain/ports/signup_flow_session.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/send_otp.dart';

class StartSignUpFlowUseCase {
  final SendOtp sendOtpUseCase;
  final SignUpFlowSession session;

  const StartSignUpFlowUseCase({
    required this.sendOtpUseCase,
    required this.session,
  });

  Future<StartSignUpResult> call({required ValidatedSignUpInput input}) async {
    session.setValidatedProductKey(input.productKey);
    session.setPendingSignUp(input);

    // Send OTP — Firebase account is created only after OTP is verified
    final otpRes = await sendOtpUseCase.call(phoneNumber: input.phone.value);

    return otpRes.fold(
      (failure) => StartSignUpFailure(failure),
      (otpResponse) {
        session.setValidationId(otpResponse.verificationId);
        return StartSignUpOtpSent(otpResponse);
      },
    );
  }
}
