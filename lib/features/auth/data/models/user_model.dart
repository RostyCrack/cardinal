import 'package:cardinal/core/database/app_database.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );
  }

  factory UserModel.fromFirebase(dynamic user) {
    return UserModel(
      id: user.uid as String,
      email: (user.email ?? '') as String,
      displayName: (user.displayName ?? 'Usuario') as String,
      phoneNumber: user.phoneNumber as String?,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      displayName: entity.displayName,
      phoneNumber: entity.phoneNumber,
    );
  }

  /// Creates a [UserModel] from a Drift-generated [User] row.
  factory UserModel.fromDrift(User row) {
    return UserModel(
      id: row.id,
      email: row.email,
      displayName: row.displayName,
      phoneNumber: row.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
      };
}
