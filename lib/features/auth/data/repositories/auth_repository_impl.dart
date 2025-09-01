import 'dart:developer';

import 'package:cardinal/features/auth/data/data_sources/firebase_data_source.dart';
import 'package:cardinal/features/auth/data/data_sources/user_local_data_source.dart';
import 'package:cardinal/features/auth/data/models/sign_up_requests.dart';
import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../exceptions/login_exceptions.dart';
import '../models/sign_up_response.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuthDataSource firebaseAuthDataSource;

  AuthRepositoryImpl({required this.firebaseAuthDataSource});

  @override
  Stream<UserEntity?> authStateChanges() {
    return firebaseAuth.authStateChanges().map(
      (user) => user != null ? UserModel.fromFirebase(user) : null,
    );
  }

  @override
  Future<Either<AuthFailure, UserModel>> signIn(
    String email,
    String password,
  ) async {
    try {
      final result = await firebaseAuthDataSource.signIn(email, password);
      return result.fold(
        (failure) {
          log(
            "AuthRepository/signIn: Error al iniciar sesión: ${failure.message}",
          );
          return Left(failure);
        },
        (loginResponse) async {
          log(
            "AuthRepository/signIn: Inicio de sesión exitoso para el usuario: ${loginResponse.userCredential.user?.email}",
          );
          final user = UserModel.fromFirebase(
            loginResponse.userCredential.user!,
          );
          return Right(user);
        },
      );
    } catch (e) {
      log("AuthRepository/signIn: Error al iniciar sesión: $e");
      return Left(LoginFailure("Error desconocido al iniciar sesión."));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() {
    log("AuthRepository/signOut: Cerrando sesión del usuario.");
    return firebaseAuthDataSource.signOut();
  }

  @override
  Future<Either<AuthFailure, SignUpResponse>> signUp(SignUpRequest request) async {
    try {
      final result = await firebaseAuthDataSource.signUp(request);
      return result.fold(
            (failure) {
          log("AuthRepository/signUp: Error -> ${failure.message}");
          return Left(failure);
        },
            (userCredential) {
          log("AuthRepository/signUp: Registro exitoso para ${userCredential.user?.email}");
          return Right(SignUpResponse(userCredential: userCredential));
        },
      );
    } catch (e, s) {
      log("AuthRepository/signUp: Excepción $e", stackTrace: s);
      return Left(AuthFailure("Error desconocido en signUp"));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> verifyPhoneNumber(
      VerifyPhoneNumberRequest request,
      ) async {
    try {
      final result = await firebaseAuthDataSource.verifyPhoneNumber(
        request
      );

      return result.fold(
            (failure) {
          log("AuthRepository/verifyPhoneNumber: Error -> ${failure.message}");
          return Left(failure);
        },
            (_) {
          log("AuthRepository/verifyPhoneNumber: SMS enviado a ${request.phoneNumber}");
          return const Right(unit);
        },
      );
    } on Exception catch (e) {
      log("AuthRepository/verifyPhoneNumber: Excepción -> $e");
      return Left(AuthFailure("Error desconocido al verificar número."));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> confirmSmsCode(
      ConfirmSmsCodeRequest request,
      ) async {
    final result = await firebaseAuthDataSource.confirmSmsCode(request);

    return result.fold(
          (failure) => Left(failure),
          (userModel) => Right(UserEntity.fromModel(userModel)),
    );
  }
}
