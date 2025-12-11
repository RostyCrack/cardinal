import 'package:cardinal/features/auth/data/models/sign_up_requests.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/exceptions/auth_exceptions.dart';

class SignUpResponse {
  final UserCredential userCredential;
  SignUpResponse({
    required this.userCredential,
  });
}

sealed class VerifyPhoneNumberResult {}

class CodeSent extends VerifyPhoneNumberResult {
  final String verificationId;
  final int? resendToken;
  CodeSent(this.verificationId, this.resendToken);
}

class VerificationCompleted extends VerifyPhoneNumberResult {
  final UserCredential userCredential;
  VerificationCompleted(this.userCredential);
}

class VerificationFailed extends VerifyPhoneNumberResult {
  final AuthFailure failure;
  VerificationFailed(this.failure);
}
