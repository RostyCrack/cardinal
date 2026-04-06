// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_sso_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterSsoRequest _$RegisterSsoRequestFromJson(Map<String, dynamic> json) =>
    RegisterSsoRequest(
      idToken: json['id_token'] as String,
      productKey: json['product_key'] as String,
      firebaseUid: json['firebase_uid'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      tokenFcm: json['token_fcm'] as String,
      systemCode: json['system_code'] as String,
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$RegisterSsoRequestToJson(RegisterSsoRequest instance) =>
    <String, dynamic>{
      'id_token': instance.idToken,
      'product_key': instance.productKey,
      'firebase_uid': instance.firebaseUid,
      'full_name': instance.fullName,
      'email': instance.email,
      'token_fcm': instance.tokenFcm,
      'system_code': instance.systemCode,
      'phone_number': ?instance.phoneNumber,
    };
