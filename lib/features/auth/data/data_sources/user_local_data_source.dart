
import 'package:cardinal/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import 'package:hive/hive.dart';
import '../../domain/exceptions/auth_exceptions.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<Either<AuthFailure, Unit>> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> deleteUser();
  Future<UserModel> updateUser(UserModel user);
}

// Implementación concreta
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box<UserModel> userBox;

  UserLocalDataSourceImpl(this.userBox);

  @override
  Future<Either<AuthFailure, Unit>> saveUser(UserModel user) async {
    await userBox.put('user', user);
    final savedUser = userBox.get('user');
    if (savedUser == null) {
      return Left(AuthFailure('Error al guardar el usuario'));
    }
    return Right(unit);
  }

  @override
  Future<UserModel?> getUser() async {
    return userBox.get('user');
  }

  @override
  Future<void> deleteUser() async {
    await userBox.delete('user');
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    await userBox.put('user', user);
    final updatedUser = userBox.get('user');
    if (updatedUser == null) {
      throw Exception('Error al actualizar el usuario');
    }
    return updatedUser;
  }
}