import 'package:cardinal/features/auth/domain/ports/signup_flow_session.dart';
import 'package:cardinal/features/auth/domain/value_objects/auth_vos.dart';

class SignUpFlowSessionImpl implements SignUpFlowSession {
  ValidatedSignUpInput? _pendingSignUp;
  ProductKey? _validatedProductKey;
  String? _validationId;

  @override
  ValidatedSignUpInput? get pendingSignUp => _pendingSignUp;

  @override
  ProductKey? get validatedProductKey => _validatedProductKey;

  @override
  String? get validationId => _validationId;

  @override
  void setPendingSignUp(ValidatedSignUpInput input) {
    _pendingSignUp = input;
  }

  @override
  void setValidatedProductKey(ProductKey key) {
    _validatedProductKey = key;
  }

  @override
  void setValidationId(String id) {
    _validationId = id;
  }

  @override
  void clearAll() {
    _pendingSignUp = null;
    _validatedProductKey = null;
    _validationId = null;
  }
}
