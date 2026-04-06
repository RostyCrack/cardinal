import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';

class SsoFailure extends AuthFailure {
  const SsoFailure(super.message);
}

class SsoRegisterFailure extends SsoFailure {
  const SsoRegisterFailure(String message) : super(message);
}

class SsoUnauthorizedFailure extends SsoFailure {
  const SsoUnauthorizedFailure() : super('SSO session expired or unauthorized.');
}

class SsoNetworkFailure extends SsoFailure {
  const SsoNetworkFailure() : super('Network error while contacting SSO service.');
}

class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure(Object? cause)
      : super('An unexpected error occurred.');
}