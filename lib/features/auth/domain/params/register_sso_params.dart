import 'package:cardinal/features/auth/domain/value_objects/auth_vos.dart';

class RegisterSsoParams {
  final IdToken idToken;
  final ProductKey productKey;
  final FirebaseUid firebaseUid;
  final Name fullName;
  final EmailAddress email;
  final String tokenFcm;
  final String systemCode;
  final PhoneNumber? phoneNumber;

  const RegisterSsoParams({
    required this.idToken,
    required this.productKey,
    required this.firebaseUid,
    required this.fullName,
    required this.email,
    required this.tokenFcm,
    required this.systemCode,
    this.phoneNumber,
  });
}