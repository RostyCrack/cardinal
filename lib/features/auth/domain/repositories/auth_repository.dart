import 'package:cardinal/features/auth/data/models/sign_up_requests.dart';
import 'package:cardinal/features/auth/data/models/sign_up_response.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/user_model.dart';
import '../entities/user_entity.dart';
import '../exceptions/auth_exceptions.dart';

abstract class AuthRepository {
  Stream<UserEntity?> authStateChanges();

  Future<Either<AuthFailure, UserModel>> signIn(String email, String password);

  Future<Either<AuthFailure, Unit>> signOut();

  Future<Either<AuthFailure, SignUpResponse>> signUp(SignUpRequest signUpRequest);

  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail(String email);
  Future<Either<AuthFailure, Unit>> verifyPhoneNumber(VerifyPhoneNumberRequest request);
  Future<Either<AuthFailure, UserEntity>> confirmSmsCode(ConfirmSmsCodeRequest request);
  
}