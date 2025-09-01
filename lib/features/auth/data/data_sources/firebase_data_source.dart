///
/// Firebase Data Source
/// This class will handle Firebase interactions for authentication.

import 'dart:async';
import 'dart:developer';

import 'package:cardinal/features/auth/data/exceptions/log_out_exceptions.dart';
import 'package:cardinal/features/auth/data/models/login_response.dart';
import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../exceptions/login_exceptions.dart';
import '../exceptions/singup_exceptions.dart';
import '../models/sign_up_requests.dart';
import '../models/user_model.dart';

abstract class FirebaseAuthDataSource {
  Future<Either<AuthFailure, LoginResponse>> signIn(
    String email,
    String password,
  );
  Future<Either<AuthFailure, UserCredential>> signUp(
      SignUpRequest signUpRequest
  );
  Future<Either<AuthFailure, Unit>> signOut();
  Future<Either<AuthFailure, Unit>> updateDisplayName(UpdateDisplayNameRequest request);
  Future<Either<AuthFailure, UserCredential>> verifyPhoneNumber(VerifyPhoneNumberRequest request);
  Future<Either<AuthFailure, UserModel>> confirmSmsCode(ConfirmSmsCodeRequest request);

}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseAuthDataSourceImpl();

  @override
  Future<Either<AuthFailure, LoginResponse>> signIn(
      String email,
      String password,
      ) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(LoginResponse(userCredential: userCredential));
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e, s) {
      log("FirebaseRepository/signIn unexpected error: $e", stackTrace: s);
      return Left(
        LoginFailure(
          'Ocurrió un error inesperado al iniciar sesión. Por favor, inténtelo de nuevo más tarde.',
        ),
      );
    }
  }

  @override
  Future<Either<AuthFailure, UserCredential>> signUp(
      SignUpRequest signUpRequest
  ) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: signUpRequest.email,
        password: signUpRequest.password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
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
      log("FirebaseAuthDataSource/signOut: ${e.code} - ${e.message}");
      return Left(
        LogoutFirebaseFailure()
      );
    } catch (e) {
      log("FirebaseAuthDataSource/signOut: Unexpected error - ${e.toString()}");
      return Left(
        LogoutUnexpectedFailure()
      );
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> confirmSmsCode(
      ConfirmSmsCodeRequest request,
      ) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: request.verificationId,
        smsCode: request.smsCode,
      );

      final userCredential =
      await firebaseAuth.signInWithCredential(credential);

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        return Left(AuthFailure("No se pudo obtener el usuario de Firebase."));
      }

      final userModel = UserModel.fromFirebase(userCredential.user);

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure("Error de Firebase: ${e.message}"));
    } catch (e) {
      return Left(AuthFailure("Error inesperado en confirmación SMS: $e"));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updateDisplayName(
      UpdateDisplayNameRequest request,
      ) async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) {
        return Left(UserNotFoundFailure());
      }

      await user.updateDisplayName(request.displayName);
      await user.reload();

      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e, s) {
      log("FirebaseRepository/updateDisplayName unexpected error: $e", stackTrace: s);
      return Left(
        AuthFailure(
          'Ocurrió un error al actualizar el nombre de usuario. Por favor, inténtelo de nuevo más tarde.',
        ),
      );
    }
  }

  @override
  Future<Either<AuthFailure, UserCredential>> verifyPhoneNumber(
      VerifyPhoneNumberRequest request,
      ) async {
    final completer = Completer<Either<AuthFailure, UserCredential>>();

    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: request.phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            final userCredential = await firebaseAuth.signInWithCredential(credential);
            completer.complete(Right(userCredential));
          } on FirebaseAuthException catch (e) {
            completer.complete(Left(_mapFirebaseAuthException(e)));
          } catch (e) {
            log("verifyPhoneNumber: Unexpected error during signInWithCredential - $e");
            completer.complete(Left(UnexpectedPhoneVerificationFailure()));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.complete(Left(_mapFirebaseAuthException(e)));
        },
        codeSent: (String verificationId, int? resendToken) {
          request.codeSentCallback!(verificationId, resendToken)!;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseAuthException(e));
    } catch (e) {
      log("verifyPhoneNumber: Unexpected error - $e");
      return Left(UnexpectedPhoneVerificationFailure());
    }

    return completer.future;
  }

  AuthFailure _mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
    // --- Phone ---
      case 'invalid-verification-code':
        return const InvalidSmsCodeFailure();
      case 'network-request-failed':
        return const PhoneVerificationProcessFailure();
      case 'too-many-requests':
        return const PhoneVerificationProcessFailure();

    // --- Login ---
      case 'user-not-found':
        return const UserNotFoundFailure();
      case 'wrong-password':
      case 'invalid-credential':
        return const WrongPasswordFailure();
      case 'invalid-email':
        return const InvalidEmailFailure();
      case 'user-disabled':
        return const UserDisabledFailure();
      case 'operation-not-allowed':
        return const OperationNotAllowedFailure();

    // --- Sign-up / Registration ---
      case 'email-already-in-use':
        return const EmailAlreadyInUseFailure();
      case 'weak-password':
        return const WeakPasswordFailure();
      case 'timeout':
        return const SignUpTimeoutFailure();

    // --- General / unexpected ---
      default:
        log("mapFirebaseAuthException: ${e.code} - ${e.message}");
        return UnexpectedAuthFailure();
    }
  }
}
