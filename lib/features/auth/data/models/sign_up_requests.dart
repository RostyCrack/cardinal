import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/exceptions/auth_exceptions.dart';

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

  VerifyPhoneNumberRequest({
    required this.phoneNumber,
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
