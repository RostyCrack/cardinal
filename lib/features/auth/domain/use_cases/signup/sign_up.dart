import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:cardinal/features/auth/domain/params/sign_up_firebase_params.dart';
import 'package:cardinal/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

/// Response returned after a successful Firebase sign-up.
class AuthenticatedUserResponse {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  const AuthenticatedUserResponse({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });
}

class SignUp {
  final AuthRepository authRepository;

  const SignUp({required this.authRepository});

  Future<Either<AuthFailure, AuthenticatedUserResponse>> call({
    required SignUpFirebaseParams params,
  }) =>
      authRepository.signUpWithParams(params);
}
