import 'dart:developer';

import 'package:cardinal/features/auth/data/data_sources/sso/sso_api_client.dart';
import 'package:cardinal/features/auth/data/models/sso/register_sso_request.dart';
import 'package:cardinal/features/auth/data/models/sso/sso_session_model.dart';
import 'package:cardinal/features/auth/domain/failures/auth_failures.dart';
import 'package:cardinal/features/auth/domain/params/register_sso_params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class SsoDataSource {
  Future<Either<SsoFailure, SsoSessionModel>> registerUser(
    RegisterSsoParams params,
  );
}

class SsoDataSourceImpl implements SsoDataSource {
  final SsoApiClient _client;

  SsoDataSourceImpl({required SsoApiClient client}) : _client = client;

  @override
  Future<Either<SsoFailure, SsoSessionModel>> registerUser(
    RegisterSsoParams params,
  ) async {
    try {
      final session = await _client.registerUser(
        RegisterSsoRequest.fromParams(params),
      );
      return Right(session);
    } on DioException catch (e) {
      log('SsoDataSource/registerUser DioException: ${e.response?.statusCode} - ${e.message}');
      if (e.response?.statusCode == 401) {
        return const Left(SsoUnauthorizedFailure());
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const Left(SsoNetworkFailure());
      }
      final message =
          (e.response?.data as Map<String, dynamic>?)?['message'] as String? ??
              e.message ??
              'SSO registration failed';
      return Left(SsoRegisterFailure(message));
    } catch (e, s) {
      log('SsoDataSource/registerUser unexpected error: $e', stackTrace: s);
      return Left(
          SsoRegisterFailure('Unexpected error during SSO registration.'));
    }
  }
}
