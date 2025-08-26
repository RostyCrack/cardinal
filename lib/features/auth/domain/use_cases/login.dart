import 'package:cardinal/core/failure/failure.dart';
import 'package:cardinal/core/use_case/use_case.dart';
import 'package:cardinal/features/auth/domain/entities/user_entity.dart';
import 'package:cardinal/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await repository.signIn(params.email, params.password);
  }
}

///Value Objects
class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}