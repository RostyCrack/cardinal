import 'dart:developer';

import 'package:cardinal/core/use_case/use_case.dart';
import 'package:cardinal/features/auth/domain/use_cases/logout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/listen_auth_state.dart';
import '../../domain/use_cases/login.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ListenAuthStateUseCase listenAuthState;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit({
    required this.listenAuthState,
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(const AuthInitial());

  void checkAuthState() {
    emit(const AuthInitial());

    listenAuthState.call(NoParams()).listen(
          (user) {
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(const Unauthenticated());
        }
      },
      onError: (error) {
        emit(AuthError(error.toString()));
      },
    );
  }

  /// 🔑 Login method
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    log("Logging in ...");
    final result = await loginUseCase(LoginParams(email: email, password: password));

    result.fold(
          (failure){
            log("AuthCubit/login failed");
            emit(AuthError(failure.message));
          },
          (user) {
            log("AuthCubit: Login successful: ${user.email}");
          emit(Authenticated(user));
          },
    );
  }


  Future<void> logout() async {
    log("AuthCubit: Logging out ...");
    final logoutResult = await logoutUseCase(NoParams());
    logoutResult.fold(
          (failure) {
        log("AuthCubit: Logout failed: ${failure.message}");
        emit(AuthError(failure.message));
      },
          (_) {
        log("AuthCubit: Logout successful");
        emit(const Unauthenticated());
      },
    );
  }


}