import 'package:cardinal/features/auth/data/models/sign_up_requests.dart';
import 'package:cardinal/features/auth/data/models/sign_up_response.dart';
import 'package:cardinal/features/auth/domain/params/sign_up_firebase_params.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/send_otp.dart';
import 'package:cardinal/features/auth/domain/use_cases/signup/sign_up.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/user_model.dart';
import '../entities/user_entity.dart';
import '../exceptions/auth_exceptions.dart';

abstract class AuthRepository {
  Stream<UserEntity?> authStateChanges();

  Future<Either<AuthFailure, UserModel>> signIn(String email, String password);

  Future<Either<AuthFailure, Unit>> signOut();

  Future<Either<AuthFailure, SignUpResponse>> signUp(SignUpRequest signUpRequest);

  /// SSO-friendly sign-up that returns an [AuthenticatedUserResponse].
  Future<Either<AuthFailure, AuthenticatedUserResponse>> signUpWithParams(
    SignUpFirebaseParams params,
  );

  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail(String email);
  Future<Either<AuthFailure, Unit>> verifyPhoneNumber(VerifyPhoneNumberRequest request);
  Future<Either<AuthFailure, UserEntity>> confirmSmsCode(ConfirmSmsCodeRequest request);

  /// Sends an OTP to [phoneNumber] and returns the verificationId.
  Future<Either<AuthFailure, OtpSentResponse>> sendOtp(String phoneNumber);

  /// Links a phone credential to the currently signed-in Firebase user.
  Future<Either<AuthFailure, Unit>> linkPhoneCredential(
    String verificationId,
    String smsCode,
  );
}