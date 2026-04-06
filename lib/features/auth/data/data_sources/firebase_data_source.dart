///
/// Firebase Data Source
/// This class will handle Firebase interactions for authentication.

import 'dart:async';
import 'dart:developer';

import 'package:cardinal/features/auth/data/exceptions/log_out_exceptions.dart';
import 'package:cardinal/features/auth/data/models/login_response.dart';
import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/send_otp.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../exceptions/login_exceptions.dart';
import '../exceptions/singup_exceptions.dart';
import '../models/sign_up_requests.dart';
import '../models/sign_up_response.dart';
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
  Future<Either<AuthFailure, VerifyPhoneNumberResult>> verifyPhoneNumber(VerifyPhoneNumberRequest request);
  Future<Either<AuthFailure, UserModel>> confirmSmsCode(ConfirmSmsCodeRequest request);

  /// Sends an OTP and returns the verificationId via [OtpSentResponse].
  Future<Either<AuthFailure, OtpSentResponse>> sendOtp(String phoneNumber);

  /// Links a phone credential to the currently signed-in user (does not sign in).
  Future<Either<AuthFailure, Unit>> linkPhoneCredential(
    String verificationId,
    String smsCode,
  );
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
      log("FirebaseAuthDataSource/confirmSmsCode: ${e.code} - ${e.message}");
      return Left(AuthFailure("Error de Firebase al verificar el código SMS"));
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
  Future<Either<AuthFailure, VerifyPhoneNumberResult>> verifyPhoneNumber(VerifyPhoneNumberRequest request) async {
    final completer = Completer<Either<AuthFailure, VerifyPhoneNumberResult>>();

    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: request.phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (credential) async {
          try {
            final userCredential = await firebaseAuth.signInWithCredential(credential);
            completer.complete(Right(VerificationCompleted(userCredential)));
          } on FirebaseAuthException catch (e) {
            completer.complete(Left(_mapFirebaseAuthException(e)));
          }
        },
        verificationFailed: (e) {
          completer.complete(Left(_mapFirebaseAuthException(e)));
        },
        codeSent: (verificationId, resendToken) {
          completer.complete(Right(CodeSent(verificationId, resendToken)));
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      completer.complete(Left(UnexpectedPhoneVerificationFailure()));
    }

    return completer.future;
  }

  @override
  Future<Either<AuthFailure, OtpSentResponse>> sendOtp(String phoneNumber) async {
    final completer = Completer<Either<AuthFailure, OtpSentResponse>>();

    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (_) {
          // Auto-verification not supported in SSO sign-up flow
          if (!completer.isCompleted) {
            completer.complete(
              Left(AuthFailure('Auto-verification not supported in this flow.')),
            );
          }
        },
        verificationFailed: (e) {
          if (!completer.isCompleted) {
            completer.complete(Left(_mapFirebaseAuthException(e)));
          }
        },
        codeSent: (verificationId, resendToken) {
          if (!completer.isCompleted) {
            completer.complete(
              Right(OtpSentResponse(
                verificationId: verificationId,
                resendToken: resendToken,
              )),
            );
          }
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete(Left(UnexpectedPhoneVerificationFailure()));
      }
    }

    return completer.future;
  }

  @override
  Future<Either<AuthFailure, Unit>> linkPhoneCredential(
    String verificationId,
    String smsCode,
  ) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final user = firebaseAuth.currentUser;
      if (user == null) {
        return Left(UserNotFoundFailure());
      }

      await user.linkWithCredential(credential);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthDataSource/linkPhoneCredential: ${e.code} - ${e.message}');
      if (e.code == 'credential-already-in-use' || e.code == 'provider-already-linked') {
        return Left(FirebaseCredentialAlreadyInUseFailure());
      }
      return Left(_mapFirebaseAuthException(e));
    } catch (e, s) {
      log('FirebaseAuthDataSource/linkPhoneCredential unexpected: $e', stackTrace: s);
      return Left(AuthFailure('Unexpected error linking phone credential.'));
    }
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
