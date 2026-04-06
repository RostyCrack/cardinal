import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';

abstract class CompleteSignUpResult {
  const CompleteSignUpResult();
}

class CompleteSignUpSuccess extends CompleteSignUpResult {
  final UserEntity user;
  const CompleteSignUpSuccess(this.user);
}

class CompleteSignUpFailure extends CompleteSignUpResult {
  final AuthFailure failure;
  const CompleteSignUpFailure(this.failure);
}

class CompleteSignUpOtpFailure extends CompleteSignUpResult {
  final AuthFailure failure;
  const CompleteSignUpOtpFailure(this.failure);
}

class CompleteSignUpPhoneAlreadyInUse extends CompleteSignUpResult {
  const CompleteSignUpPhoneAlreadyInUse();
}

class CompleteSignUpNoPending extends CompleteSignUpResult {
  const CompleteSignUpNoPending();
}

class CompleteSignUpProductKeyNotValidated extends CompleteSignUpResult {
  const CompleteSignUpProductKeyNotValidated();
}
