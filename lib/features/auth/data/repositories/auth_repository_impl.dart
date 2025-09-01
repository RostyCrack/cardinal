import 'dart:developer';

import 'package:cardinal/features/auth/data/data_sources/firebase_data_source.dart';
import 'package:cardinal/features/auth/data/data_sources/user_local_data_source.dart';
import 'package:cardinal/features/auth/data/models/sign_up_request.dart';
import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
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
  Future<Either<AuthFailure, UserModel>> signIn(String email, String password) async {
    try {
      final result = await firebaseAuthDataSource.signIn(email, password);
      return result.fold(
            (failure){
              log("AuthRepository/signIn: Error al iniciar sesión: ${failure.message}");
              return Left(failure);
            },
            (loginResponse) async {
              log("AuthRepository/signIn: Inicio de sesión exitoso para el usuario: ${loginResponse.userCredential.user?.email}");
          final user = UserModel.fromFirebase(loginResponse.userCredential.user!);
          return Right(user);
        },
      );
    } catch (e) {
      log("AuthRepository/signIn: Error al iniciar sesión: $e");
      return Left(LoginException("Error desconocido al iniciar sesión."));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, UserModel>> signUp(SignUpRequest signUpRequest) async {
    try {
      final result = await firebaseAuthDataSource.signUp(
        signUpRequest.email,
        signUpRequest.password,
      );

      return result.fold(
            (failure) {
          log("AuthRepository/signUp: Error al registrar el usuario: ${failure.message}");
          return Left(failure);
        },
            (userCredential) async {
          log("AuthRepository/signUp: Registro exitoso para el usuario: ${userCredential.user?.email}");
          final user = UserModel.fromFirebase(userCredential.user);
          return Right(user);
        },
      );
    } on Exception catch (e) {
      log("AuthRepository/signUp: Error al registrar el usuario: $e");
      return Left(AuthFailure("Error desconocido al registrar el usuario."));
    }
  }






}