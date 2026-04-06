import 'dart:developer';

import 'package:cardinal/features/auth/data/results/login_and_register_result.dart';
import 'package:cardinal/features/auth/domain/use_cases/auth/login_and_register_sso_use_case.dart';
import 'package:cardinal/features/auth/domain/value_objects/auth_vos.dart';
import 'package:cardinal/features/auth/presentation/cubit/sso_login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SsoLoginCubit extends Cubit<SsoLoginState> {
  final LoginAndRegisterSsoUseCase loginAndRegisterSsoUseCase;

  SsoLoginCubit({required this.loginAndRegisterSsoUseCase})
      : super(const SsoLoginInitial());

  Future<void> loginWithSso({
    required String email,
    required String password,
    required String productKey,
  }) async {
    emit(const SsoLoginLoading());
    log('SsoLoginCubit: starting SSO login for $email');

    final result = await loginAndRegisterSsoUseCase(
      email: email,
      password: password,
      productKey: ProductKey(productKey),
    );

    if (result is LoginAndRegisterSuccess) {
      log('SsoLoginCubit: SSO login successful');
      emit(SsoLoginSuccess(result.user));
    } else if (result is LoginAndRegisterUserNotFound) {
      log('SsoLoginCubit: user not found in Firebase');
      emit(const SsoLoginUserNotFound());
    } else if (result is LoginAndRegisterFailure) {
      log('SsoLoginCubit: SSO login failed: ${result.failure.message}');
      emit(SsoLoginError(result.failure.message));
    }
  }
}
