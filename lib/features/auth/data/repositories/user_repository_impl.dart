import 'package:cardinal/features/auth/data/models/user_model.dart';
import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:cardinal/features/auth/domain/exceptions/account_exceptions.dart';
import 'package:cardinal/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../data_sources/user_local_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;
  UserRepositoryImpl({required this.userLocalDataSource});

  @override
  Future<void> deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<UserFailure, UserModel>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<UserFailure, Unit>> saveUser(UserEntity user) async {
    try {
      await userLocalDataSource.saveUser(UserModel.fromEntity(user));
      return Future.value(Right(unit));
    } catch (e) {
      return Future.value(Left(UserFailure("Error al guardar el usuario localmente: $e")));
    }
  }

  @override
  Future<void> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}