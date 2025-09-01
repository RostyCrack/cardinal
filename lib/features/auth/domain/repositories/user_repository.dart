import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:cardinal/features/auth/domain/exceptions/account_exceptions.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<void> deleteUser();
  Future<void> updateUser();
  Future<Either<UserFailure, Unit>> saveUser(UserEntity user);
  Future<Either<UserFailure, UserModel>> getUser();
}