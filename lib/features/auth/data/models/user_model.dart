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

  @override
  @HiveField(3)
  final String? phoneNumber;

  const UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.phoneNumber,
  }) : super(id: id, email: email, displayName: displayName, phoneNumber: phoneNumber);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      phoneNumber: json['phoneNumber'],
    );
  }

  factory UserModel.fromFirebase(dynamic user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? "Usuario",
      phoneNumber: user.phoneNumber,
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'displayName': displayName,
    'phoneNumber': phoneNumber,
  };

}