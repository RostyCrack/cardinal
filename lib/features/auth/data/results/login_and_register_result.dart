import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';

abstract class LoginAndRegisterResult {}

class LoginAndRegisterSuccess extends LoginAndRegisterResult {
  final UserEntity user;
  LoginAndRegisterSuccess(this.user);
}

class LoginAndRegisterFailure extends LoginAndRegisterResult {
  final AuthFailure failure;
  LoginAndRegisterFailure(this.failure);
}

/// Returned when Firebase reports user-not-found or invalid-credential,
/// meaning the account doesn't exist yet in Firebase.
class LoginAndRegisterUserNotFound extends LoginAndRegisterResult {}
