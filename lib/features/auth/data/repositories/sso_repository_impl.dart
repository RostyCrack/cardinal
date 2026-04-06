import 'package:cardinal/features/auth/data/data_sources/sso/sso_data_source.dart';
import 'package:cardinal/features/auth/domain/entities/sso_session.dart';
import 'package:cardinal/features/auth/domain/failures/auth_failures.dart';
import 'package:cardinal/features/auth/domain/params/register_sso_params.dart';
import 'package:cardinal/features/auth/domain/repositories/sso_repository.dart';
import 'package:dartz/dartz.dart';

class SsoRepositoryImpl implements SsoRepository {
  final SsoDataSource ssoDataSource;

  SsoRepositoryImpl({required this.ssoDataSource});

  @override
  Future<Either<SsoFailure, SsoSession>> registerUser(
    RegisterSsoParams params,
  ) =>
      ssoDataSource.registerUser(params);
}
