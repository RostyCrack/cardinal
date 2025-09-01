import 'package:cardinal/core/use_case/use_case.dart';
import 'package:cardinal/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class LogoutUseCase extends UseCase<Unit, NoParams, AuthFailure> {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  @override
  Future<Either<AuthFailure, Unit>> call(NoParams) async {
    await authRepository.signOut();
    return Right(unit);
  }
}