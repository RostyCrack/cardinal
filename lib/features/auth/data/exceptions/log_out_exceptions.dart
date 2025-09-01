import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';

class LogoutFailure extends AuthFailure {
  const LogoutFailure(super.message);
}

class LogoutFirebaseFailure extends LogoutFailure {
  const LogoutFirebaseFailure() : super("Hubo un error al cerrar sesión, por favor intente de nuevo.");
}

class LogoutUnexpectedFailure extends LogoutFailure {
  const LogoutUnexpectedFailure() : super("Ocurrió un error inesperado al cerrar sesión, por favor intente de nuevo.");
}