import 'package:cardinal/core/use_case/use_case.dart';
import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:cardinal/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class LogoutUseCase extends UseCase<Unit, NoParams, AuthFailure> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  LogoutUseCase(this.authRepository,
      this.userRepository);

  @override
  Future<Either<AuthFailure, Unit>> call(NoParams params) async {
    await authRepository.signOut();
    await userRepository.deleteUser();
    return Right(unit);
  }
}