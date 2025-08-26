import 'dart:developer';

import 'package:cardinal/features/auth/data/data_sources/firebase_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../exceptions/login_exceptions.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuthDataSource firebaseAuthDataSource;



  AuthRepositoryImpl({
    required this.firebaseAuthDataSource,
  });

  @override
  Stream<UserEntity?> authStateChanges() {
    return firebaseAuth.authStateChanges().map(
          (user) => user != null ? UserModel.fromFirebase(user) : null,
    );
  }


  @override
  Future<Either<Failure, UserEntity>> signIn(String email, String password) async {
    try {
      final result = await firebaseAuthDataSource.signIn(email, password);
      return result.fold(
            (failure){
              log("AuthRepository/signIn: Error al iniciar sesión: ${failure.message}");
              return Left(failure);
            },
            (loginResponse) {
              log("AuthRepository/signIn: Inicio de sesión exitoso para el usuario: ${loginResponse.userCredential.user?.email}");
          final user = UserModel.fromFirebase(loginResponse.userCredential.user!);
          return Right(user);
        },
      );
    } catch (e) {
      return Left(LoginException(e.toString()));
    }
  }





}