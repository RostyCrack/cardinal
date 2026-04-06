import 'package:cardinal/core/constants/sso/sso_constants.dart';
import 'package:cardinal/features/auth/data/models/sso/register_sso_request.dart';
import 'package:cardinal/features/auth/data/models/sso/sso_session_model.dart';
import 'package:dio/dio.dart';

abstract class SsoApiClient {
  Future<SsoSessionModel> registerUser(RegisterSsoRequest body);
}

class SsoApiClientImpl implements SsoApiClient {
  final Dio _dio;
  final String _baseUrl;

  SsoApiClientImpl(this._dio, {String? baseUrl})
      : _baseUrl = baseUrl ?? SSO_BASE_URL;

  @override
  Future<SsoSessionModel> registerUser(RegisterSsoRequest body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '$_baseUrl/auth/register',
      data: body.toJson(),
    );
    return SsoSessionModel.fromJson(response.data!);
  }
}
