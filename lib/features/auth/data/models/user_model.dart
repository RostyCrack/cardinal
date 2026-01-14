// data/models/user_model.dart
import 'package:hive/hive.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.displayName,
    required super.phoneNumber,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'displayName': displayName,
    'phoneNumber': phoneNumber,
  };

  factory UserModel.fromMap(Map map) => UserModel(
    id: map['id'],
    email: map['email'],
    displayName: map['displayName'],
    phoneNumber: map['phoneNumber'],
  );

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


class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    return UserModel(
      id: reader.readString(),
      email: reader.readString(),
      displayName: reader.readString(),
      phoneNumber: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.email);
    writer.writeString(obj.displayName!);
    writer.writeString(obj.phoneNumber!);
  }
}