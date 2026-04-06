import 'package:cardinal/features/auth/domain/value_objects/auth_vos.dart';

class ValidatedSignUpInput {
  final EmailAddress email;
  final PasswordVO password;
  final PhoneNumber phone;
  final Name name;
  final ProductKey productKey;
  final String photoUrl;

  const ValidatedSignUpInput({
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
    required this.productKey,
    this.photoUrl = '',
  });
}

abstract class SignUpFlowSession {
  ValidatedSignUpInput? get pendingSignUp;
  ProductKey? get validatedProductKey;
  String? get validationId;

  void setPendingSignUp(ValidatedSignUpInput input);
  void setValidatedProductKey(ProductKey key);
  void setValidationId(String id);
  void clearAll();
}
