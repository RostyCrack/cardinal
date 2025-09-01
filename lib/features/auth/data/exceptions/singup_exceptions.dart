import 'package:cardinal/core/failure/failure.dart';
import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';

class SignUpFailure extends AuthFailure {
  const SignUpFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class UserAlreadyExistsFailure extends SignUpFailure {
  const UserAlreadyExistsFailure() : super('El usuario ya existe');
}

class InvalidSignUpEmailFailure extends SignUpFailure {
  const InvalidSignUpEmailFailure() : super('Dirección de correo electrónico inválida');
}

class WeakPasswordFailure extends SignUpFailure {
  const WeakPasswordFailure() : super('La contraseña es demasiado débil');
}

class UnexpectedSignUpFailure extends SignUpFailure {
  const UnexpectedSignUpFailure(super.message);
}

class SignUpTimeoutFailure extends SignUpFailure {
  const SignUpTimeoutFailure() : super('El registro ha superado el tiempo de espera');
}

class EmailAlreadyInUseFailure extends SignUpFailure {
  const EmailAlreadyInUseFailure() : super('El correo electrónico ya está en uso');
}

/// Base para todos los errores relacionados con la verificación telefónica
class PhoneVerificationFailure extends AuthFailure {
  const PhoneVerificationFailure(super.message);

  @override
  List<Object?> get props => [message];
}

/// Código SMS ingresado incorrectamente
class InvalidSmsCodeFailure extends PhoneVerificationFailure {
  const InvalidSmsCodeFailure()
      : super('El código ingresado es incorrecto. Verifícalo e inténtalo de nuevo.');
}

/// Error técnico en la verificación (ej: problemas de red, Firebase bloquea la petición, etc.)
class PhoneVerificationProcessFailure extends PhoneVerificationFailure {
  const PhoneVerificationProcessFailure()
      : super('Hubo un problema al procesar la verificación del teléfono.');
}

/// Timeout en la verificación automática
class PhoneVerificationTimeoutFailure extends PhoneVerificationFailure {
  const PhoneVerificationTimeoutFailure()
      : super('La verificación ha superado el tiempo de espera.');
}

/// Error desconocido
class UnexpectedPhoneVerificationFailure extends PhoneVerificationFailure {
  const UnexpectedPhoneVerificationFailure([super.message = 'Ocurrió un error desconocido en la verificación.']);
}