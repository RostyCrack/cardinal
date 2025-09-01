

import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';

import '../../../../core/failure/failure.dart';

class LoginException extends AuthFailure {
  const LoginException(super.message);
}

class MaximumAccountsException extends LoginException {
  const MaximumAccountsException() : super('Se ha alcanzado el máximo de cuentas permitidas.');
}

class UserNotFoundException extends LoginException {
  const UserNotFoundException() : super('Usuario no encontrado. Por favor, regístrese.');
}

class WrongPasswordException extends LoginException {
  const WrongPasswordException() : super('Email y/o contraseña incorrecta. Por favor, inténtelo de nuevo.');
}

class InvalidEmailException extends LoginException {
  const InvalidEmailException() : super('El correo electrónico no es válido.');
}

class UserDisabledException extends LoginException {
  const UserDisabledException() : super('El usuario ha sido deshabilitado.');
}

class TooManyRequestsException extends LoginException {
  const TooManyRequestsException() : super('Se ha bloqueado el acceso a este usuario temporalmente debido a muchos intentos de inicio de sesión fallidos. Por favor, inténtelo de nuevo más tarde.');
}

class OperationNotAllowedException extends LoginException {
  const OperationNotAllowedException() : super('El inicio de sesión por correo electrónico y contraseña no está habilitado.');
}

class NetworkRequestFailedException extends LoginException {
  const NetworkRequestFailedException() : super('Por favor, revise su conexión a internet y vuelva a intentarlo.');
}

class NoAccountTypeException extends LoginException {
  const NoAccountTypeException() : super('No se encontró el tipo de cuenta. Por favor, contacte al soporte.');
}
