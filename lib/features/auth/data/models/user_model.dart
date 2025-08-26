import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.id, super.email});

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      id: user.uid,
      email: user.email,
    );
  }
}