import 'package:cardinal/features/auth/domain/value_objects/auth_vos.dart';

class SignUpFirebaseParams {
  final EmailAddress emailAddress;
  final PasswordVO password;
  final Name name;

  const SignUpFirebaseParams({
    required this.emailAddress,
    required this.password,
    required this.name,
  });
}
