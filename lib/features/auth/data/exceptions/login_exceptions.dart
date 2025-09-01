import '../../domain/exceptions/auth_exceptions.dart';

class LoginFailure extends AuthFailure {
  const LoginFailure(super.message);
}

class MaximumAccountsFailure extends LoginFailure {
  const MaximumAccountsFailure() : super('Se ha alcanzado el máximo de cuentas permitidas.');
}

class UserNotFoundFailure extends LoginFailure {
  const UserNotFoundFailure() : super('Usuario no encontrado. Por favor, regístrese.');
}

class WrongPasswordFailure extends LoginFailure {
  const WrongPasswordFailure() : super('Email y/o contraseña incorrecta. Por favor, inténtelo de nuevo.');
}

class InvalidEmailFailure extends LoginFailure {
  const InvalidEmailFailure() : super('El correo electrónico no es válido.');
}

class UserDisabledFailure extends LoginFailure {
  const UserDisabledFailure() : super('El usuario ha sido deshabilitado.');
}

class TooManyRequestsFailure extends LoginFailure {
  const TooManyRequestsFailure() : super('Se ha bloqueado el acceso a este usuario temporalmente debido a muchos intentos de inicio de sesión fallidos. Por favor, inténtelo de nuevo más tarde.');
}

class OperationNotAllowedFailure extends LoginFailure {
  const OperationNotAllowedFailure() : super('El inicio de sesión por correo electrónico y contraseña no está habilitado.');
}

class NetworkRequestFailedFailure extends LoginFailure {
  const NetworkRequestFailedFailure() : super('Por favor, revise su conexión a internet y vuelva a intentarlo.');
}

class NoAccountTypeFailure extends LoginFailure {
  const NoAccountTypeFailure() : super('No se encontró el tipo de cuenta. Por favor, contacte al soporte.');
}

class UnexpectedAuthFailure extends AuthFailure {
  const UnexpectedAuthFailure() : super('Ocurrió un error inesperado. Por favor, inténtelo de nuevo más tarde.');
}
