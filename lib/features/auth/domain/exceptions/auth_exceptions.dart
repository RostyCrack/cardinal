import 'package:cardinal/core/failure/failure.dart';

class AuthFailure extends Failure{
  const AuthFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure() : super('No se encuentra el usuario');
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure() : super('Invalid credentials');
}

class UserAlreadyExistsFailure extends AuthFailure {
  const UserAlreadyExistsFailure() : super('User already exists');
}

class UnexpectedAuthFailure extends AuthFailure {
  const UnexpectedAuthFailure(super.message);
}

class AuthTimeoutFailure extends AuthFailure {
  const AuthTimeoutFailure() : super('Authentication timed out');
}

