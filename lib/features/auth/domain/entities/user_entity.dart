import 'package:cardinal/features/auth/data/models/user_model.dart';

class UserEntity {
  final String id;
  final String email;
  final String? displayName;
  final String? phoneNumber;


  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.phoneNumber,
  });

  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      id: model.id,
      email: model.email,
      displayName: model.displayName,
    );
  }


}