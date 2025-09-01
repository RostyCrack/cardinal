import 'package:cardinal/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:cardinal/features/auth/presentation/cubit/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/sign_up_requests.dart';
import '../../domain/use_cases/confirm_sms_use_case.dart';
import '../../domain/use_cases/save_user_locally.dart';
import '../../domain/use_cases/verify_phone_use_case.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final ConfirmSmsCodeUseCase confirmSmsCodeUseCase;
  final SaveUserLocallyUseCase saveUserLocallyUseCase;
  final SignUpUseCase signUpUseCase;

  SignUpCubit({
    required this.verifyPhoneNumberUseCase,
    required this.confirmSmsCodeUseCase,
    required this.saveUserLocallyUseCase,
    required this.signUpUseCase,
  }) : super(SignUpInitial());

  Future<void> startSignUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(SignUpLoading());

    final result = await signUpUseCase(
      SignUpRequest(
        email: email,
        password: password,
        name: name,
        phone: phone,
      ),
    );

    await result.fold(
          (failure) async => emit(SignUpError(failure.message)),
          (user) async {
        // ✅ email/password creado, ahora pedir verificación del número
        final verifyResult = await verifyPhoneNumberUseCase(
          VerifyPhoneNumberRequest(
            phoneNumber: phone,
            codeSentCallback: (verificationId, token) {
              emit(SignUpCodeSent());
            },
          ),
        );
        verifyResult.fold(
              (failure) => emit(SignUpError(failure.message)),
              (_) {},
        );
      },
    );
  }

  Future<void> confirmCode(String smsCode, String verificationId) async {
    emit(SignUpVerifyingCode());

    final result = await confirmSmsCodeUseCase(
      ConfirmSmsCodeRequest(
        verificationId: verificationId,
        smsCode: smsCode,
      ),
    );

    result.fold(
          (failure) => emit(SignUpError(failure.message)),
          (userEntity) async {
        await saveUserLocallyUseCase(userEntity);

        emit(SignUpSuccess());
      },
    );
  }
}