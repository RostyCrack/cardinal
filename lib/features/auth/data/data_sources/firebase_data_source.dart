
///
/// Firebase Data Source
/// This class will handle Firebase interactions for authentication.

import 'dart:developer';

import 'package:cardinal/features/auth/data/models/login_response.dart';
import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../exceptions/login_exceptions.dart';

abstract class FirebaseAuthDataSource {
  Future<Either<LoginException, LoginResponse>> signIn(String email, String password);
  Future<Either<LoginException, UserCredential>> signUp(String email, String password);
  Future<Either<AuthFailure, Unit>> signOut();
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseAuthDataSourceImpl();

  @override
  Future<Either<LoginException, LoginResponse>> signIn(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(LoginResponse(userCredential: userCredential));
    }on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return Left(UserNotFoundException());
        case 'wrong-password':
          return Left(WrongPasswordException());
        case 'invalid-email':
          return Left(InvalidEmailException());
        case 'user-disabled':
          return Left(UserDisabledException());
        case 'too-many-requests':
          return Left(TooManyRequestsException());
        case 'operation-not-allowed':
          return Left(OperationNotAllowedException());
        case 'network-request-failed':
          return Left(NetworkRequestFailedException());
        case 'invalid-credential':
          return Left(WrongPasswordException());
        default:
          log("FirebaseRepository/signIn: ${e.code} - ${e.message}");
          return Left(LoginException(
              'Ocurrió un error al iniciar sesión. Por favor, inténtelo de nuevo más tarde.'));
      }
    }
  }

  @override
  Future<Either<LoginException, UserCredential>> signUp(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(LoginException('Error during signUp: ${e.message}'));
    } catch (e) {
      throw Exception("Unexpected error during signUp: $e");
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await firebaseAuth.signOut();
      return const Right(unit); // Éxito
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Error al cerrar sesión'));
    } catch (e) {
      return Left(AuthFailure('Error desconocido al cerrar sesión'));
    }
  }

}