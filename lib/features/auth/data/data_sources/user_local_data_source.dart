import 'package:cardinal/core/database/app_database.dart';
import 'package:cardinal/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import '../../domain/exceptions/auth_exceptions.dart';

abstract class UserLocalDataSource {
  Future<Either<AuthFailure, Unit>> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> deleteUser();
  Future<UserModel> updateUser(UserModel user);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final AppDatabase _db;

  UserLocalDataSourceImpl(this._db);

  @override
  Future<Either<AuthFailure, Unit>> saveUser(UserModel user) async {
    try {
      await _db.into(_db.users).insertOnConflictUpdate(
            UsersCompanion(
              id: Value(user.id),
              email: Value(user.email),
              displayName: Value(user.displayName),
              phoneNumber: Value(user.phoneNumber),
            ),
          );
      return const Right(unit);
    } catch (e) {
      return Left(AuthFailure('Error al guardar el usuario: $e'));
    }
  }

  @override
  Future<UserModel?> getUser() async {
    final row = await (_db.select(_db.users)..limit(1)).getSingleOrNull();
    if (row == null) return null;
    return UserModel.fromDrift(row);
  }

  @override
  Future<void> deleteUser() async {
    await _db.delete(_db.users).go();
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    await _db.into(_db.users).insertOnConflictUpdate(
          UsersCompanion(
            id: Value(user.id),
            email: Value(user.email),
            displayName: Value(user.displayName),
            phoneNumber: Value(user.phoneNumber),
          ),
        );
    return user;
  }
}
