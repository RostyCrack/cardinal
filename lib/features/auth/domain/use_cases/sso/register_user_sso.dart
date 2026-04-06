import 'package:cardinal/features/auth/domain/entities/sso_session.dart';
import 'package:cardinal/features/auth/domain/failures/auth_failures.dart';
import 'package:cardinal/features/auth/domain/params/register_sso_params.dart';
import 'package:cardinal/features/auth/domain/repositories/sso_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUserSso {
  final SsoRepository ssoRepository;

  const RegisterUserSso({required this.ssoRepository});

  Future<Either<SsoFailure, SsoSession>> call(RegisterSsoParams params) =>
      ssoRepository.registerUser(params);
}
