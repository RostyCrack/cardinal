import 'package:firebase_auth/firebase_auth.dart';

class SignUpRequest {
  final String email;
  final String password;
  final String name;
  final String phone;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    };
  }
}

class VerifyPhoneNumberRequest {
  final String phoneNumber;
  final Function(String verificationId, int? resendToken)? codeSentCallback;

  VerifyPhoneNumberRequest({
    required this.phoneNumber,
    required this.codeSentCallback,
  });
}

class ConfirmSmsCodeRequest {
  final String verificationId;
  final String smsCode;

  ConfirmSmsCodeRequest({
    required this.verificationId,
    required this.smsCode,
  });
}

class UpdateDisplayNameRequest {
  final UserCredential userCredential;
  final String displayName;

  UpdateDisplayNameRequest({
    required this.displayName,
    required this.userCredential,
  });
}