// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sso_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SsoSessionModel _$SsoSessionModelFromJson(Map<String, dynamic> json) =>
    SsoSessionModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      userId: json['user_id'] as String,
      expiresIn: (json['expires_in'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SsoSessionModelToJson(SsoSessionModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'user_id': instance.userId,
      'expires_in': instance.expiresIn,
    };
