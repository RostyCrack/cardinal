import 'package:cardinal/features/auth/data/models/user_model.dart';
import 'package:cardinal/features/auth/domain/entities/sso_session.dart';

class UserEntity {
  final String id;
  final String email;
  final String? displayName;
  final String? phoneNumber;
  final SsoSession? ssoSession;

  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.phoneNumber,
    this.ssoSession,
  });

  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      id: model.id,
      email: model.email,
      displayName: model.displayName,
    );
  }

  factory UserEntity.fromFirebaseUidAndSso({
    required String uid,
    required String email,
    required SsoSession ssoSession,
    String? displayName,
    String? phoneNumber,
    String photoUrl = '',
  }) {
    return UserEntity(
      id: uid,
      email: email,
      displayName: displayName,
      phoneNumber: phoneNumber,
      ssoSession: ssoSession,
    );
  }
}