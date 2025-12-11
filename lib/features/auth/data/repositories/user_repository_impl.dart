import 'dart:developer';

import 'package:cardinal/features/auth/data/models/user_model.dart';
import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:cardinal/features/auth/domain/exceptions/account_exceptions.dart';
import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:cardinal/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../data_sources/user_local_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;
  UserRepositoryImpl({required this.userLocalDataSource});

  @override
  Future<Either<AuthFailure, Unit>> deleteUser() {
    try{
      userLocalDataSource.deleteUser();
      return Future.value(Right(unit));
    }
    catch(e){
      log("UserRepository/deleteUser: Error al eliminar el usuario localmente: $e");
      return Future.value(Left(AuthFailure("Error al eliminar el usuario localmente")));
    }
  }

  @override
  Future<Either<UserFailure, UserModel>> getUser() async {
    try {
      final user = await userLocalDataSource.getUser();
      if (user != null) {
        return Future.value(Right(user));
      } else {
        return Future.value(Left(UserFailure("No se encontró un usuario localmente.")));
      }
    } catch (e) {
      return Future.value(Left(UserFailure("Error al obtener el usuario localmente: $e")));
    }
  }

  @override
  Future<Either<UserFailure, Unit>> saveUser(UserEntity user) async {
    try {
      await userLocalDataSource.saveUser(UserModel.fromEntity(user));
      return Future.value(Right(unit));
    } catch (e) {
      log("UserRepository/saveUser: Error al guardar el usuario localmente: $e");
      return Future.value(Left(UserFailure("Error al guardar el usuario localmente")));
    }
  }

  @override
  Future<void> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}