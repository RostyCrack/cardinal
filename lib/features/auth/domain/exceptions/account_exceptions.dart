import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';

class UserFailure extends AuthFailure{
  const UserFailure(super.message);
}

class UnableToSaveAccountException extends UserFailure {
  const UnableToSaveAccountException() : super("No fue posible guardar la cuenta del usuario.");
}

class UnableToGetAccountException extends UserFailure {
  const UnableToGetAccountException() : super("No fue posible obtener la cuenta del usuario.");
}

class UnableToDeleteAccountException extends UserFailure {
  const UnableToDeleteAccountException() : super("No fue posible eliminar la cuenta del usuario.");
}

