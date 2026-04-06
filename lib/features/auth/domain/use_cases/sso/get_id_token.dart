import 'dart:developer';

import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:cardinal/features/auth/domain/value_objects/auth_vos.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetIdToken {
  final FirebaseAuth _firebaseAuth;

  GetIdToken({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<Either<AuthFailure, IdToken>> call() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Left(AuthFailure('No authenticated Firebase user found.'));
      }
      final token = await user.getIdToken();
      if (token == null) {
        return Left(AuthFailure('Failed to retrieve ID token.'));
      }
      return Right(IdToken(token));
    } catch (e, s) {
      log('GetIdToken error: $e', stackTrace: s);
      return Left(AuthFailure('Unexpected error retrieving ID token.'));
    }
  }
}
