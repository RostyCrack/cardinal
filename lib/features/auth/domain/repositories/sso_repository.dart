import 'package:cardinal/features/auth/domain/entities/sso_session.dart';
import 'package:cardinal/features/auth/domain/failures/auth_failures.dart';
import 'package:cardinal/features/auth/domain/params/register_sso_params.dart';
import 'package:dartz/dartz.dart';

abstract class SsoRepository {
  Future<Either<SsoFailure, SsoSession>> registerUser(RegisterSsoParams params);
}
