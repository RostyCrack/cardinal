import 'dart:developer';

import 'package:cardinal/core/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/listen_auth_state.dart';
import '../../domain/use_cases/login.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ListenAuthStateUseCase listenAuthState;
  final LoginUseCase loginUseCase;

  AuthCubit({
    required this.listenAuthState,
    required this.loginUseCase,
  }) : super(const AuthInitial());

  void checkAuthState() {
    emit(const AuthInitial());
    var userResponse = listenAuthState.call(NoParams());
    userResponse.then((result) {
      result.fold(
            (failure) => emit(AuthError(failure.message)),
            (stream) {
          stream.listen((user) {
            if (user != null) {
              emit(Authenticated(user));
            } else {
              emit(const Unauthenticated());
            }
          });
        },
      );
    });
  }

  /// 🔑 Login method
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    log("Logging in ...");
    final result = await loginUseCase(LoginParams(email: email, password: password));

    result.fold(
          (failure){
            log("Cubit/login failed");
            emit(AuthError(failure.message));
          },
          (user) {
            log("Login successful: ${user.email}");
          emit(Authenticated(user));
          },
    );
  }
}