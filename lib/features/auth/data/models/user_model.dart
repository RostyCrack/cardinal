// data/models/user_model.dart
import 'package:hive/hive.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0) // id único para este model
class UserModel extends UserEntity {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String email;

  @HiveField(2)
  @override
  final String? displayName;

  const UserModel({
    required this.id,
    required this.email,
    required this.displayName,
  }) : super(id: id, email: email, displayName: displayName);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
    );
  }

  factory UserModel.fromFirebase(dynamic user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? "Usuario",
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      displayName: entity.displayName,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
  };

}