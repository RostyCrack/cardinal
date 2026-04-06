import 'package:cardinal/features/auth/domain/params/register_sso_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_sso_request.g.dart';

@JsonSerializable(includeIfNull: false)
class RegisterSsoRequest {
  @JsonKey(name: 'id_token')
  final String idToken;

  @JsonKey(name: 'product_key')
  final String productKey;

  @JsonKey(name: 'firebase_uid')
  final String firebaseUid;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;

  @JsonKey(name: 'token_fcm')
  final String tokenFcm;

  @JsonKey(name: 'system_code')
  final String systemCode;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  const RegisterSsoRequest({
    required this.idToken,
    required this.productKey,
    required this.firebaseUid,
    required this.fullName,
    required this.email,
    required this.tokenFcm,
    required this.systemCode,
    this.phoneNumber,
  });

  factory RegisterSsoRequest.fromParams(RegisterSsoParams params) {
    return RegisterSsoRequest(
      idToken: params.idToken.value,
      productKey: params.productKey.value,
      firebaseUid: params.firebaseUid.value,
      fullName: params.fullName.value,
      email: params.email.value,
      tokenFcm: params.tokenFcm,
      systemCode: params.systemCode,
      phoneNumber: params.phoneNumber?.value,
    );
  }

  factory RegisterSsoRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterSsoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterSsoRequestToJson(this);
}
