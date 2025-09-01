import 'package:dartz/dartz.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/sign_up_requests.dart';
import '../entities/user_entity.dart';
import '../exceptions/auth_exceptions.dart';
import '../repositories/auth_repository.dart';

class ConfirmSmsCodeUseCase
    extends UseCase<UserEntity, ConfirmSmsCodeRequest, AuthFailure> {
  final AuthRepository authRepository;

  ConfirmSmsCodeUseCase(this.authRepository);

  @override
  Future<Either<AuthFailure, UserEntity>> call(ConfirmSmsCodeRequest request) {
    return authRepository.confirmSmsCode(request);
  }
}