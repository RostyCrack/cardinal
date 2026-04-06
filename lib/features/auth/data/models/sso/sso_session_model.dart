import 'package:cardinal/features/auth/domain/entities/sso_session.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sso_session_model.g.dart';

@JsonSerializable()
class SsoSessionModel extends SsoSession {
  @JsonKey(name: 'access_token')
  @override
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  @override
  final String refreshToken;

  @JsonKey(name: 'user_id')
  @override
  final String userId;

  @JsonKey(name: 'expires_in')
  @override
  final int? expiresIn;

  const SsoSessionModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    this.expiresIn,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
          userId: userId,
          expiresIn: expiresIn,
        );

  factory SsoSessionModel.fromJson(Map<String, dynamic> json) =>
      _$SsoSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SsoSessionModelToJson(this);
}
