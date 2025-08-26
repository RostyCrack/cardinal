import 'package:cardinal/core/failure/failure.dart';

class SignUpFailure extends Failure {
  const SignUpFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class UserAlreadyExistsFailure extends SignUpFailure {
  const UserAlreadyExistsFailure() : super('El usuario ya existe');
}

class InvalidEmailFailure extends SignUpFailure {
  const InvalidEmailFailure() : super('Dirección de correo electrónico inválida');
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